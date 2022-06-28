//
//  FlowCoordinatorManager.swift
//  DPFlowCoordinator
//
//  Created by 张鹏 on 2019/8/26.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

/// `FlowCoordinator`管理器
@objc(FCFlowCoordinatorManager)
public class FlowCoordinatorManager: NSObject {
    
    /// 单例
    @objc(sharedManager)
    public static let shared = FlowCoordinatorManager()
    
    /// 协调器
    private lazy var coordinators = [ObjectIdentifier: FlowCoordinatorType]()
    
    /// 协调器
    private lazy var stringKeyCoordinators = [String: FlowCoordinatorType]()
    
    /// 单例限制
    private override init() {}
    
    /// 添加流程协调器
    /// - Parameter flowCoordinator: 流程协调器
    /// - Parameter identifier: 标识符
    func addFlowCoordinator(_ flowCoordinator: FlowCoordinatorType, for identifier: ObjectIdentifier) {
        coordinators[identifier] = flowCoordinator
    }
    
    /// 移除流程协调器
    /// - Parameter identifier: 标识符
    func removeFlowCoordinator(for identifier: ObjectIdentifier) {
        coordinators.removeValue(forKey: identifier)
    }
    
    /// 添加流程协调器
    /// - Parameter flowCoordinator: 流程协调器
    /// - Parameter identifier: 标识符
    @objc(addFlowCoordinator:forIdentifier:)
    public func addFlowCoordinator(_ flowCoordinator: FlowCoordinatorType, for identifier: String) {
        stringKeyCoordinators[identifier] = flowCoordinator
    }
    
    /// 移除流程协调器
    /// - Parameter identifier: 标识符
    @objc(removeFlowCoordinatorForIdentifier:)
    public func removeFlowCoordinator(for identifier: String) {
        stringKeyCoordinators.removeValue(forKey: identifier)
    }
}
