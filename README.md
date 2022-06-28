# DPFlowCoordinator
`流程协调器`，根据[Krzysztof Zabłocki](https://twitter.com/merowing_)的[文章](https://academy.realm.io/cn/posts/krzysztof-zablocki-mDevCamp-ios-architecture-mvvm-mvc-viper/)来实现的，适用于：`F+MVC`、`F+MVVM`、`F+VIPER`

[TOC]

## 安装

使用`CocoaPods`
```
pod 'DPFlowCoordinator', '~> 3.0.0'
```



## Swift使用

一般的使用方式是建立`FlowCoordinator`子类来处理业务流程，子类需要指定流程成功返回的结果，通过父类的范型来指定(下面例子中的`Result`)

```swift
import DPFlowCoordinator

class LoginFlow: FlowCoordinator<Result> {

    override func start(at baseViewController: UIViewController?, completion: CompletionHandler?) {
        super.start(at: baseViewController, completion: completion)

        // 在这里处理你的业务流程
    }

    func doSomething() {
        // ⚠️️️️️️⚠️⚠️ 在业务流程完成后，需要调用`complete()`方法，来结束流程，否则`FlowCoordinator`生命周期不会完结，并且内存不会被释放
      	// 
      	end(with: .skip)
    }
}
```

定义`Result`，每个流程可以定义自己的`Result`

```swift
extension LoginFlow {
    
    enum Result {
        case skip
        case failure(Error)
        case success(User)
    }
}
```

实现好了业务流程之后，在`ViewController`中调用业务流程

```swift
class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func needsLoginButtonDidClick(_ sender: Any) {

        LoginFlow().start(at: self) { (result) -> (Void) in
            switch result {
            case .skip:
                print("取消登录")
            case let .success(userInfo):
                print("登录成功:\(String(describing: userInfo))")
            case let .failure(error):
                print("登录失败\(String(describing: error))")
            }
        }
    }    
}
```

> 更多细节，请参考工程中的`DPFlowCoordinatorExample`



## ObjC使用

**DPFlowCoordinator**提供了ObjC的API

自己的业务流程需要继承自**`FCFlowCoordinator`**

```objc
#import <DPFlowCoordinator/DPFlowCoordinator.h>

@interface SettingPasswordFlow : FCFlowCoordinator
  
@end
```

然后重写`startAtViewController:completion:`方法，并在这里开始你的业务流程

⚠️⚠️⚠️ 重写`startAtViewController:completion:`一定要调用**`super startAtViewController:completion:`**

```objc
@implementation SettingPasswordFlow

- (void)startAtViewController:(UIViewController *)baseViewController
                   completion:(void (^)(FCFlowCoordinatorResult * _Nonnull))completionHandler {
    [super startAtViewController:baseViewController completion:completionHandler];
    
    [self showSettingPasswordPage];
}

@end
```

在你的业务流程结束或者终止时，需要调用**`endWithXXX`**方法来使流程完结，不然流程不能完结会导致内存泄露（⚠️⚠️⚠️）

```objective-c
- (void)showSettingPasswordPage {
    
    __weak typeof (self) weakself = self;
    
    SettingPasswordViewController *passwordPage = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingPasswordViewController"];
    passwordPage.cancelAction = ^(SettingPasswordViewController * _Nonnull page) {
        [page dismissViewControllerAnimated:YES completion:nil];
        [weakself endWithCancel];
    };
    
    passwordPage.finishAction = ^(SettingPasswordViewController * _Nonnull page) {
        [page dismissViewControllerAnimated:YES completion:nil];
        [weakself endWithSuccessData:@{@"name": @"张三", @"age": @(18)}];
    };
    
    passwordPage.failureAction = ^(SettingPasswordViewController * _Nonnull page, NSError * _Nonnull error) {
        [page dismissViewControllerAnimated:YES completion:^{
            [weakself endWithFailureError:error];
        }];
    };
    
    [self.baseViewController presentViewController:passwordPage animated:YES completion:nil];
}
```

业务流程的调用

```objc
[[[SettingPasswordFlow alloc] init] startAtViewController:self completion:^(FCFlowCoordinatorResult * _Nonnull result) {
    switch (result.category) {
        case FCFlowCoordinatorResultCategoryCancel: {
            NSLog(@"%s, 取消", __PRETTY_FUNCTION__);
        } break;
        case FCFlowCoordinatorResultCategorySuccess: {
            NSLog(@"%s, 成功: %@", __PRETTY_FUNCTION__, result.data);
        } break;
        case FCFlowCoordinatorResultCategoryFailure: {
            NSLog(@"%s, 失败: %@", __PRETTY_FUNCTION__, result.error);
            [weakself alertMessage:result.error.localizedDescription atPage:weakself];
        } break;
    }
}];
```



## 参考文档

- [Krzysztof Zabłocki的中文版文章](https://academy.realm.io/cn/posts/krzysztof-zablocki-mDevCamp-ios-architecture-mvvm-mvc-viper/)
- [Krzysztof Zabłocki的英文版文章](https://academy.realm.io/posts/krzysztof-zablocki-mDevCamp-ios-architecture-mvvm-mvc-viper/)



## LICENSE 

DPFlowCoordinator is released under the MIT license. See [LICENSE](LICENSE) for details.