//
//  LoginViewController.swift
//  DPFlowCoordinatorExample
//
//  Created by 张鹏 on 2019/8/26.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit

/// `LoginViewController`相关回调
protocol LoginViewControllerDelegate: AnyObject {
    
    /// 点击取消按钮
    func loginViewController(_ viewController: LoginViewController, didClickCancelButton button: UIButton)
    
    /// 点击完成按钮
    func loginViewController(_ viewController: LoginViewController, didClickFinishButton button: UIButton)
    
    /// 点击开始注册流程按钮
    func loginViewController(_ viewController: LoginViewController, didClickStartRegisterFlowButton button: UIButton)
}

class LoginViewController: UIViewController {
    
    /// 代理
    weak var delegate: LoginViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func cancelButtonDidClick(_ sender: Any) {
        delegate?.loginViewController(self, didClickCancelButton: sender as! UIButton)        
    }
    
    @IBAction func finishButtonDidClick(_ sender: Any) {
        delegate?.loginViewController(self, didClickFinishButton: sender as! UIButton)
    }
    
    @IBAction func startRegisterFlowButtonDidClick(_ sender: Any) {
        delegate?.loginViewController(self, didClickStartRegisterFlowButton: sender as! UIButton)
    }
}
