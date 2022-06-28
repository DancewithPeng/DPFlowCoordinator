//
//  SettingPasswordViewController.h
//  DPFlowCoordinatorObjCExample
//
//  Created by 张鹏 on 2022/6/28.
//  Copyright © 2022 dancewithpeng@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingPasswordViewController : UIViewController

@property (nonatomic, copy, nullable) void (^cancelAction)(SettingPasswordViewController *);
@property (nonatomic, copy, nullable) void (^finishAction)(SettingPasswordViewController *);
@property (nonatomic, copy, nullable) void (^failureAction)(SettingPasswordViewController *page, NSError *error);

@end

NS_ASSUME_NONNULL_END
