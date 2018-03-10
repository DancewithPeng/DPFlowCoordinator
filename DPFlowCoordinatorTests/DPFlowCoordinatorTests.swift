//
//  DPFlowCoordinatorTests.swift
//  DPFlowCoordinatorTests
//
//  Created by DancewithPeng on 2018/3/9.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import XCTest
@testable import DPFlowCoordinator

class DPFlowCoordinatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        print("哈哈哈哈")
    }
    
    
    func testAddAndRemove() {
        /*
        let mainFlow = DPFlowCoordinator()
        let flow1 = DPFlowCoordinator()
        let flow2 = DPFlowCoordinator()
        
        mainFlow.add(childCoordinator: flow1)
        print(mainFlow.childCoordinators)
        mainFlow.add(childCoordinator: flow2)
        print(mainFlow.childCoordinators)
        mainFlow.remove(childCoordinator: flow2)
        print(mainFlow.childCoordinators)
        mainFlow.remove(childCoordinator: flow1)
        print(mainFlow.childCoordinators)
        */
    }
    
    func testFlow() {
        
        let mainFlowCoordinator = DPFlowCoordinator()
        let loginFlowCoordiantor = DPFlowCoordinator(parentFlowCoordinator: mainFlowCoordinator)
        print(mainFlowCoordinator.childFlowCoordinators)
        print(loginFlowCoordiantor.parentFlowCoordinator)
        
        let registerFlowCoordinator = DPFlowCoordinator(parentFlowCoordinator: loginFlowCoordiantor)
        print(mainFlowCoordinator.childFlowCoordinators)
        print(loginFlowCoordiantor.childFlowCoordinators)
        print(registerFlowCoordinator.parentFlowCoordinator)
    }
    
    func testViewControllerExtension() {
        let nav = UINavigationController()
        let mainFlowCoordinator = DPFlowCoordinator(baseViewController: nav)
        print(mainFlowCoordinator.baseViewController)
        print(mainFlowCoordinator.navigationController)
        print(mainFlowCoordinator.tabBarController)
        
        let tab = UITabBarController()
        let loginFlowCoordinator = DPFlowCoordinator(parentFlowCoordinator: mainFlowCoordinator, baseViewController: tab)
        print(loginFlowCoordinator.parentFlowCoordinator)
        print(loginFlowCoordinator.baseViewController)
        print(loginFlowCoordinator.navigationController)
        print(loginFlowCoordinator.tabBarController)
    }
}
