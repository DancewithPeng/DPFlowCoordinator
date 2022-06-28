//
//  FCFlowCoordinator.m
//  DPFlowCoordinator
//
//  Created by 张鹏 on 2022/6/28.
//  Copyright © 2022 dancewithpeng@gmail.com. All rights reserved.
//

#import "FCFlowCoordinator.h"
#import <DPFlowCoordinator/DPFlowCoordinator-Swift.h>


#pragma mark - FCFlowCoordinator


@interface FCFlowCoordinator () <FlowCoordinatorType>

@property (nonatomic, strong, nullable) void (^completionHandler)(FCFlowCoordinatorResult * _Nonnull); ///< 完成的处理
@property (nonatomic, copy) NSString *identifier; ///< 标识符

@end

@implementation FCFlowCoordinator

- (instancetype)init {
    self = [super init];
    if (self) {
        self.identifier = [NSString stringWithFormat:@"%p", self];
    }
    return self;
}

+ (instancetype)flow {
    return [[self alloc] init];
}

- (void)startAtViewController:(UIViewController *)baseViewController completion:(void (^)(FCFlowCoordinatorResult * _Nonnull))completionHandler {
    self.baseViewController = baseViewController;
    self.completionHandler = completionHandler;
    [FCFlowCoordinatorManager.sharedManager addFlowCoordinator:self forIdentifier:self.identifier];
}

- (void)endWithResult:(FCFlowCoordinatorResult *)result {
    if (self.completionHandler) {
        self.completionHandler(result);
    }
    [self clearUp];
}

#pragma mark - Helper Methods

- (void)clearUp {
    self.completionHandler = nil;
    [FCFlowCoordinatorManager.sharedManager removeFlowCoordinatorForIdentifier:self.identifier];
}

@end


#pragma mark - FCFlowCoordinatorResult


@implementation FCFlowCoordinatorResult

- (instancetype)initWithCategory:(FCFlowCoordinatorResultCategory)category
                            data:(NSDictionary *)data
                           error:(NSError *)error {
    
    if (self = [super init]) {
        self.category = category;
        self.data     = data;
        self.error    = error;
    }
    return self;
}

+ (instancetype)cancel {
    return [[FCFlowCoordinatorResult alloc] initWithCategory:FCFlowCoordinatorResultCategoryCancel
                                                        data:nil
                                                       error:nil];
}

+ (instancetype)successWithData:(NSDictionary *)data {
    return [[FCFlowCoordinatorResult alloc] initWithCategory:FCFlowCoordinatorResultCategorySuccess
                                                        data:data
                                                       error:nil];
}

+ (instancetype)failureWithError:(NSError *)error {
    return [[FCFlowCoordinatorResult alloc] initWithCategory:FCFlowCoordinatorResultCategoryFailure
                                                        data:nil
                                                       error:error];
}

@end

@implementation FCFlowCoordinator (FCFlowCoordinatorResult)

- (void)endWithCancel {
    [self endWithResult:[FCFlowCoordinatorResult cancel]];
}

- (void)endWithSuccessData:(NSDictionary *)data {
    [self endWithResult:[FCFlowCoordinatorResult successWithData:data]];
}

- (void)endWithFailureError:(NSError *)error {
    [self endWithResult:[FCFlowCoordinatorResult failureWithError:error]];
}

@end
