//
//  SettingPasswordViewController.m
//  DPFlowCoordinatorObjCExample
//
//  Created by 张鹏 on 2022/6/28.
//  Copyright © 2022 dancewithpeng@gmail.com. All rights reserved.
//

#import "SettingPasswordViewController.h"

@interface SettingPasswordViewController ()

@end

@implementation SettingPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)cancelButtonDidTap:(id)sender {
    if (self.cancelAction) {
        self.cancelAction(self);
    }
}

- (IBAction)finishButtonDidTap:(id)sender {
    if (self.finishAction) {
        self.finishAction(self);
    }
}

- (IBAction)failureButtonDidTap:(id)sender {
    if (self.failureAction) {
        self.failureAction(self, [NSError errorWithDomain:@"demo.demo" code:10086 userInfo:@{
            NSLocalizedFailureReasonErrorKey: @"演示的失败"
        }]);
    }
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
