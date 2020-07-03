//
//  DPFlowCoordinator.swift
//  DPFlowCoordinator
//
//  Created by DancewithPeng on 2018/3/9.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit

/// 流程协调器，用于处理业务流程
/// 
/// 此为基类，不应直接调用此类，而应该子类化，在子类处理相关业务逻辑
open class FlowCoordinator<UserInfo, Error: Swift.Error> {
    
    /// 流程完成的处理
    private var completionHandler: CompletionHandler?
    
    /// 标识符
    private lazy var identifier = "\(Unmanaged.passUnretained(self).toOpaque())"
    
    /// 对应的`UIViewController`
    public weak var viewController: UIViewController?
        
    /// 初始化方法
    public init() {}
    
    /// 开始流程，子类应该重写此方法以开始处理流程
    /// 如果子类重写此方法，应当调用 `super.start(in:completion:)`
    ///
    /// - Parameter completion: 流程完成后的处理，默认为nil
    open func start(in viewController: UIViewController?, completion: CompletionHandler?) {
        self.viewController = viewController
        completionHandler = completion
        
        FlowCoordinatorManager.shared.addFlowCoordinator(self, for: identifier)
    }
    
    /// 取消流程
    /// 如果子类重写此方法，应当调用 `super.cancel()`
    ///
    /// - Parameter error: 取消的错误信息，默认为nil
    open func cancel() {
        completionHandler?(.cancel)
        clearUp()
    }
    
    /// 使流程失败
    ///
    /// 如果子类重写此方法，应当调用 `super.fail(_:)`
    /// - Parameter error: 对应的错误信息
    open func fail(_ error: Error) {
        completionHandler?(.failure(error))
        clearUp()
    }
    
    /// 完成流程
    /// 如果子类重写此方法，应当调用 `super.finish(_:)`
    ///
    /// - Parameter userInfo: 完成时需要携带的用户信息
    open func finish(_ userInfo: UserInfo) {
        completionHandler?(.finish(userInfo))
        clearUp()
    }
    
    /// 清除操作
    private func clearUp() {
        completionHandler = nil
        FlowCoordinatorManager.shared.removeFlowCoordinator(for: identifier)
    }
}

// MARK: - Hashable
extension FlowCoordinator: Hashable where UserInfo: Any {
    
    public static func == (lhs: FlowCoordinator, rhs: FlowCoordinator) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

// MARK: - DPFlowCoordinator UIKit扩展
public extension FlowCoordinator {
    
    /// 基于的导航控制器，如果baseViewController是UINavigationController，则返回对应的导航控制器，反之则返回nil
    var navigationController: UINavigationController? {
        if let nav = viewController as? UINavigationController {
            return nav
        }
        return viewController?.navigationController
    }
    
    /// 基于的分栏控制器，如果baseViewController是UITabBarController，则返回对应的分栏控制器，反之则返回nil
    var tabBarController: UITabBarController? {
        if let tab = viewController as? UITabBarController {
            return tab
        }
        return viewController?.tabBarController
    }
}


// MARK: - Types
public extension FlowCoordinator {
    
    /// 流程协调器完成处理
    typealias CompletionHandler = (Result) -> (Void)
    
    /// 结果
    enum Result {
        /// 取消
        case cancel
        /// 失败
        case failure(Error)
        /// 完成
        case finish(UserInfo)
    }
}
