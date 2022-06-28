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
open class FlowCoordinator<Result>: FlowCoordinatorType {
    
    // MARK: - Properties
    
    /// 流程完成的处理
    private var completionHandler: CompletionHandler?
    
    /// 标识符
    private lazy var identifier = ObjectIdentifier(self)
    
    /// 对应的`UIViewController`
    public weak var baseViewController: UIViewController?
    
    
    // MARK: - Life Cycle Methods
        
    /// 初始化方法
    public init() {}
    
    // MARK: - Hooksll
    
    /// 开始流程，子类应该重写此方法以开始处理流程
    /// 如果子类重写此方法，应当调用 `super.start(at:completion:)`
    ///
    /// - Parameter completion: 流程完成后的处理，默认为nil
    open func start(at baseViewController: UIViewController?, completion: CompletionHandler?) {
        self.baseViewController = baseViewController
        self.completionHandler  = completion
        
        FlowCoordinatorManager.shared.addFlowCoordinator(self, for: identifier)
    }
            
    /// 开始流程，子类不应该重写此方法，仅为支持Swift Concurrency语法
    /// - Parameter baseViewController: 基础页面
    /// - Returns: 返回对应的结果
    @available(iOS 13, *)
    public func start(at baseViewController: UIViewController?) async -> Result {
        return await withUnsafeContinuation { continuation in
            DispatchQueue.main.async { [weak self] in
                self?.start(at: baseViewController) { result in
                    continuation.resume(returning: result)
                }
            }
        }
    }
    
    /// 完成流程
    ///
    /// 如果子类重新此方法，应当调用`super.end(with_:)`
    /// - Parameter result: 结果
    open func end(with result: Result) {
        completionHandler?(result)
        clearUp()
    }
    
    // MARK: - Helper Methods
    
    /// 清除操作
    private func clearUp() {
        completionHandler = nil
        FlowCoordinatorManager.shared.removeFlowCoordinator(for: identifier)
    }
}

// MARK: - Types
public extension FlowCoordinator {
    
    /// 流程协调器完成处理
    typealias CompletionHandler = (Result) -> Void
}
