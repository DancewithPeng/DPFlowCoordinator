//
//  SettingPasswordFlow.m
//  DPFlowCoordinatorObjCExample
//
//  Created by 张鹏 on 2022/6/28.
//  Copyright © 2022 dancewithpeng@gmail.com. All rights reserved.
//

#import "SettingPasswordFlow.h"
#import "SettingPasswordViewController.h"

@implementation SettingPasswordFlow

- (void)startAtViewController:(UIViewController *)baseViewController
                   completion:(void (^)(FCFlowCoordinatorResult * _Nonnull))completionHandler {
    [super startAtViewController:baseViewController completion:completionHandler];
    
    [self showSettingPasswordPage];
}

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



@end
