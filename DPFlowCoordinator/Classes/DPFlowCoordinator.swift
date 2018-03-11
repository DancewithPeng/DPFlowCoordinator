//
//  DPFlowCoordinator.swift
//  DPFlowCoordinator
//
//  Created by DancewithPeng on 2018/3/9.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit


/// 流程协调器完成处理
public typealias DPFlowCoordinatorCompletionHandler = (_ finished: Bool, _ userInfo: Any?, _ error: Error?) -> (Void)


/// 流程协调器，用于处理业务流程
/// 此为基类，不应直接调用此类，而应该子类化，在子类处理相关业务逻辑
open class DPFlowCoordinator: NSObject {
    
    /// 子流程协调器
    public lazy var childFlowCoordinators = Array<DPFlowCoordinator>()
    
    /// 父流程协调器
    public weak var parentFlowCoordinator: DPFlowCoordinator?
    
    /// 流程完成的处理
    private var completionHandler: DPFlowCoordinatorCompletionHandler?
    
    /// 关联对象
    private lazy var associatedObjects = Dictionary<String, Any>()
    
    
    /// 初始化方法，指定父流程协调器，默认为nil
    ///
    /// - Parameter parentFlowCoordinator: 父流程协调器
    public init(parentFlowCoordinator: DPFlowCoordinator? = nil) {
        super.init()
        
        parentFlowCoordinator?.addChildFlowCoordinator(self)
    }
    
    
    /// 添加子流程协调器
    ///
    /// - Parameter childCoordinator: 子协调器
    public func addChildFlowCoordinator(_ childFlowCoordinator: DPFlowCoordinator) {
        if childFlowCoordinators.contains(childFlowCoordinator) == false {
            childFlowCoordinator.parentFlowCoordinator = self
            childFlowCoordinators.append(childFlowCoordinator)
        }
    }
    
    
    /// 移除子流程协调器
    ///
    /// - Parameter childCoordinator: 子协调器
    public func removeChildFlowCoordinator(_ childFlowCoordinator: DPFlowCoordinator) {
        if let index = childFlowCoordinators.index(of: childFlowCoordinator) {
            childFlowCoordinator.parentFlowCoordinator = nil
            childFlowCoordinators.remove(at: index)
        }
    }
    
    
    /// 开始流程，子类应该重写此方法以开始处理流程
    /// 如果子类重写此方法，应当调用 `super.start(completion: completion)`
    ///
    /// - Parameter completion: 流程完成后的处理，默认为nil
    open func start(completion: DPFlowCoordinatorCompletionHandler? = nil) {
        completionHandler = completion
    }
    
    
    /// 取消流程
    /// 如果子类重写此方法，应当调用 `super.cancel(error: error)`
    ///
    /// - Parameter error: 取消的错误信息，默认为nil
    open func cancel(error: Error? = nil) {
        completionHandler?(false, nil, error)
        complete()
    }
    
    
    /// 完成流程
    /// 如果子类重写此方法，应当调用 `super.finish(userInfo: userInfo)`
    ///
    /// - Parameter userInfo: 完成时需要附带的用户信息
    open func finish(userInfo: Any? = nil) {
        completionHandler?(true, userInfo, nil)
        complete()
    }
    
    
    /// 完成处理
    private func complete() {
        completionHandler = nil
        parentFlowCoordinator?.removeChildFlowCoordinator(self)
    }
}


// MARK: - DPFlowCoordinator UIKit扩展
public extension DPFlowCoordinator {
    
    /// 基础视图控制器，流程协调器是基于此视图控制器开始的
    public var baseViewController: UIViewController? {
        if let baseVC = self.associatedObjects["baseViewController"] as? UIViewController {
            return baseVC
        }
        return nil
    }
    
    /// 基于的导航控制器，如果baseViewController是UINavigationController，则返回对应的导航控制器，反之则返回nil
    public var navigationController: UINavigationController? {
        if let nav = self.baseViewController as? UINavigationController {
            return nav
        }
        return nil
    }
    
    /// 基于的分栏控制器，如果baseViewController是UITabBarController，则返回对应的分栏控制器，反之则返回nil
    public var tabBarController: UITabBarController? {
        if let tab = self.baseViewController as? UITabBarController {
            return tab
        }
        return nil
    }
    
    
    /// 便捷初始化方法
    ///
    /// - Parameters:
    ///   - parentFlowCoordinator: 父流程协调器
    ///   - baseViewController: 基础视图控制器
    public convenience init(parentFlowCoordinator: DPFlowCoordinator? = nil, baseViewController: UIViewController) {
        self.init(parentFlowCoordinator: parentFlowCoordinator)
        
        self.associatedObjects["baseViewController"] = baseViewController
    }
    
    
}
