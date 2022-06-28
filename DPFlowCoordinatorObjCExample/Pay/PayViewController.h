//
//  PayViewController.h
//  DPFlowCoordinatorObjCExample
//
//  Created by 张鹏 on 2022/6/28.
//  Copyright © 2022 dancewithpeng@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayFlow.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayViewController : UIViewController

@property (nonatomic, weak) PayFlow *flow;

@end

NS_ASSUME_NONNULL_END
