//
//  PayFlow.m
//  DPFlowCoordinatorObjCExample
//
//  Created by 张鹏 on 2022/6/28.
//  Copyright © 2022 dancewithpeng@gmail.com. All rights reserved.
//

#import "PayFlow.h"
#import "PayViewController.h"

@implementation PayFlow

- (void)startAtViewController:(UIViewController *)baseViewController completion:(void (^)(FCFlowCoordinatorResult * _Nonnull))completionHandler {
    [super startAtViewController:baseViewController completion:completionHandler];
    
    [self showPayPage];
}

- (void)showPayPage {
    PayViewController *payPage = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PayViewController"];
    payPage.flow = self;
    [self.baseViewController presentViewController:payPage animated:YES completion:nil];
}

@end
