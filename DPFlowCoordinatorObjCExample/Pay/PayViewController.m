//
//  PayViewController.m
//  DPFlowCoordinatorObjCExample
//
//  Created by 张鹏 on 2022/6/28.
//  Copyright © 2022 dancewithpeng@gmail.com. All rights reserved.
//

#import "PayViewController.h"
#import "SettingPasswordFlow.h"

@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)cancelButtonDidTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.flow endWithCancel];
}

- (IBAction)finishButtonDidTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.flow endWithSuccessData:@{@"demo": @"😂"}];
}

- (IBAction)settingPasswordButtonDidTap:(id)sender {
    __weak typeof (self) weakself = self;
    [[SettingPasswordFlow flow] startAtViewController:self completion:^(FCFlowCoordinatorResult * _Nonnull result) {
        switch (result.category) {
            case FCFlowCoordinatorResultCategoryCancel: {
                NSLog(@"%s, 取消", __PRETTY_FUNCTION__);
            } break;
            case FCFlowCoordinatorResultCategorySuccess: {
                NSLog(@"%s, 成功: %@", __PRETTY_FUNCTION__, result.data);
            } break;
            case FCFlowCoordinatorResultCategoryFailure: {
                NSLog(@"%s, 失败: %@", __PRETTY_FUNCTION__, result.error);
                [weakself dismissViewControllerAnimated:YES completion:^{
                    [weakself.flow endWithFailureError:result.error];
                }];
            } break;
        }
    }];
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
