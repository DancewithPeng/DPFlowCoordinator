//
//  main.m
//  DPFlowCoordinatorObjCExample
//
//  Created by 张鹏 on 2022/6/28.
//  Copyright © 2022 dancewithpeng@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
