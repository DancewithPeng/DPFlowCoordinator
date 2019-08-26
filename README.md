# DPFlowCoordinator
`流程协调器`，根据[Krzysztof Zabłocki](https://twitter.com/merowing_)的[文章](https://academy.realm.io/cn/posts/krzysztof-zablocki-mDevCamp-ios-architecture-mvvm-mvc-viper/)来实现的，适用于：`F+MVC`、`F+MVVM`、`F+VIPER`

## 安装
使用`CocoaPods`
```
pod 'DPFlowCoordinator', '~> 2.0.0'
```

## 使用
一般的使用方式是建立`FlowCoordinator`子类来处理业务流程，子类需要指定流程成功返回的信息，通过父类的范型来指定(下面例子中的`<User>`)
```swift
import DPFlowCoordinator

class LoginFlowCoordinator: FlowCoordinator<User> {

    override func start(in viewController: UIViewController?, completion: CompletionHandler?) {
        super.start(in: viewController, completion: completion)

        // 在这里处理你的业务流程
    }

    func doSomething() {
        // ⚠️️️️️️⚠️⚠️ 在业务流程完成后，需要调用`cancel()`或`finished()`方法，来结束流程，否则`FlowCoordinator`生命周期不会完结，并且内存不会被释放

        // `finish()`方法可以返回必要的信息
        // finish(user) 

        // `cancel()`方法可以返回必要的错误信息
        // cancel(error)
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

        LoginFlowCoordinator().start(in: self) { (result) -> (Void) in
            switch result {
            case let .finished(user):
                // 流程成功处理逻辑            
            case let .canceled(error):
                // 流程取消处理逻辑
            }
        }
    }    
}
```

> 更多细节，请参考工程中的`DPFlowCoordinatorExample`

## 参考连接
- [Krzysztof Zabłocki的中文版文章](https://academy.realm.io/cn/posts/krzysztof-zablocki-mDevCamp-ios-architecture-mvvm-mvc-viper/)
- [Krzysztof Zabłocki的英文版文章](https://academy.realm.io/posts/krzysztof-zablocki-mDevCamp-ios-architecture-mvvm-mvc-viper/)

## LICENSE 
DPFlowCoordinator is released under the MIT license. See [LICENSE](LICENSE) for details.