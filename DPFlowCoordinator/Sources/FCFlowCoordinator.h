//
//  FCFlowCoordinator.h
//  DPFlowCoordinator
//
//  Created by 张鹏 on 2022/6/28.
//  Copyright © 2022 dancewithpeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

/// 流程结果类型
typedef NS_ENUM(NSUInteger, FCFlowCoordinatorResultCategory) {
    FCFlowCoordinatorResultCategoryCancel,
    FCFlowCoordinatorResultCategorySuccess,
    FCFlowCoordinatorResultCategoryFailure,
};

/// 流程结果
@interface FCFlowCoordinatorResult : NSObject

@property (nonatomic, assign          ) FCFlowCoordinatorResultCategory category;   ///< 类型
@property (nonatomic, strong, nullable) NSDictionary                    *data;      ///< 数据
@property (nonatomic, strong, nullable) NSError                         *error;     ///< 错误

- (instancetype)initWithCategory:(FCFlowCoordinatorResultCategory)category data:(NSDictionary * _Nullable)data error:(NSError * _Nullable)error;

+ (instancetype)cancel;
+ (instancetype)successWithData:(NSDictionary * _Nullable)data;
+ (instancetype)failureWithError:(NSError * _Nullable)error;

@end

/// 流程协调器
@interface FCFlowCoordinator : NSObject

@property (nonatomic, weak, nullable) UIViewController *baseViewController;

- (instancetype)init;
+ (instancetype)flow;

- (void)startAtViewController:(UIViewController * _Nullable)baseViewController completion:(void (^)(FCFlowCoordinatorResult *))completionHandler;
- (void)endWithResult:(FCFlowCoordinatorResult *)result;

@end

/// 流程协调器便捷方法
@interface FCFlowCoordinator (FCFlowCoordinatorResult)

- (void)endWithCancel;
- (void)endWithSuccessData:(NSDictionary * _Nullable)data;
- (void)endWithFailureError:(NSError * _Nullable)error;

@end

NS_ASSUME_NONNULL_END
