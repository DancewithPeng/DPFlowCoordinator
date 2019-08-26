//
//  ViewController.swift
//  DPFlowCoordinatorExample
//
//  Created by 张鹏 on 2019/8/26.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginFlowButtonDidClick(_ sender: Any) {
        let loginFlow = LoginFlowCoordinator()
        loginFlow.start(in: self) { (result) -> (Void) in
            switch result {
            case let .finished(userInfo):
                print("登录成功:\(String(describing: userInfo))")
            case let .canceled(error):
                print("登录失败\(String(describing: error))")
            }
        }
    }
    
    @IBAction func registerFlowButtonDidClick(_ sender: Any) {
        RegisterFlowCoordinator().start(in: self) { (result) -> (Void) in
            switch result {
            case let .finished(userInfo):
                print("注册成功\(String(describing: userInfo))")
            case let .canceled(error):
                print("注册成功\(String(describing: error))")
            }
        }
    }
}
