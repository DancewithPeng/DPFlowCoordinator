//
//  ViewController.m
//  DPFlowCoordinatorObjCExample
//
//  Created by 张鹏 on 2022/6/28.
//  Copyright © 2022 dancewithpeng@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "SettingPasswordFlow.h"
#import "PayFlow.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)payButtonDidTap:(id)sender {
    __weak typeof (self) weakself = self;
    [[PayFlow flow] startAtViewController:self completion:^(FCFlowCoordinatorResult * _Nonnull result) {
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
}

- (IBAction)settingPasswordButtonDidTap:(id)sender {
    __weak typeof (self) weakself = self;
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
}

- (void)alertMessage:(NSString *)message atPage:(UIViewController *)page {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
    }]];
    
    [page presentViewController:alertController animated:YES completion:nil];
}

@end
