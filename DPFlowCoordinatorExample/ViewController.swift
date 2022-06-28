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
        loginFlow.start(at: self) { (result) -> (Void) in
            switch result {
            case .skip:
                print("跳过")
            case let .success(user):
                print("登录成功:\(user)")
            case .failure:
                print("登录失败")
            }
        }
    }
    
    @IBAction func registerFlowButtonDidClick(_ sender: Any) {
        RegisterFlowCoordinator().start(at: self) { (result) -> (Void) in
            switch result {
            case let .success(info):
                print("注册成功\(info)")
            case let .failure(error):
                print("注册失败\(error)")
            }
        }
    }
}

