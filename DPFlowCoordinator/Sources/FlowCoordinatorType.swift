//
//  FlowCoordinatorType.swift
//  DPFlowCoordinator
//
//  Created by 张鹏 on 2022/6/28.
//  Copyright © 2022 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation
import UIKit

/// 流程协调器类型
@objc
public protocol FlowCoordinatorType {
    
    /// 对应的基础`UIViewController`
    var baseViewController: UIViewController? { get }
}

// MARK: - DPFlowCoordinator UIKit扩展

public extension FlowCoordinatorType {
    
    /// 基页面的导航控制器，如果baseViewController是UINavigationController，则返回对应的导航控制器，反之则返回nil
    var navigationController: UINavigationController? {
        if let nav = baseViewController as? UINavigationController {
            return nav
        }
        return baseViewController?.navigationController
    }
    
    /// 基页面的分栏控制器，如果baseViewController是UITabBarController，则返回对应的分栏控制器，反之则返回nil
    var tabBarController: UITabBarController? {
        if let tab = baseViewController as? UITabBarController {
            return tab
        }
        return baseViewController?.tabBarController
    }
}
