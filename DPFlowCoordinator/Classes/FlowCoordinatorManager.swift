//
//  FlowCoordinatorManager.swift
//  DPFlowCoordinator
//
//  Created by 张鹏 on 2019/8/26.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

/// `FlowCoordinator`管理器
class FlowCoordinatorManager {
    
    /// 单例
    static let shared = FlowCoordinatorManager()
    
    /// 协调器数组
    private lazy var coordinators = [ObjectIdentifier: Any]()
    
    /// 单例限制
    private init() {}
    
    /// 添加流程协调器
    ///
    /// - Parameter flowCoordinator: 流程协调器
    func addFlowCoordinator(_ flowCoordinator: Any, for indentifier: ObjectIdentifier) {
        coordinators[indentifier] = flowCoordinator
    }
    
    /// 移除流程协调器
    ///
    /// - Parameter flowCoordinator: 流程协调器
    func removeFlowCoordinator(for indentifier: ObjectIdentifier) {
        coordinators.removeValue(forKey: indentifier)
    }
}
