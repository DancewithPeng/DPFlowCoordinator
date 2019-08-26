//
//  LoginFlowCoordinator.swift
//  DPFlowCoordinatorExample
//
//  Created by 张鹏 on 2019/8/26.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation
import DPFlowCoordinator


/// 登录流程
class LoginFlowCoordinator: FlowCoordinator<String> {
    
    override func start(in viewController: UIViewController?, completion: CompletionHandler?) {
        super.start(in: viewController, completion: completion)
        showLoginPage()
    }
    
    func showLoginPage() {
        guard let loginPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
        
        loginPage.delegate = self
        viewController?.present(loginPage, animated: true, completion: nil)
    }
    
    deinit {
        print("\(self) did deinit!!!")
    }
}

// MARK: - LoginViewControllerDelegate
extension LoginFlowCoordinator: LoginViewControllerDelegate {
    
    func loginViewController(_ viewController: LoginViewController, didClickCancelButton button: UIButton) {
        cancel()
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func loginViewController(_ viewController: LoginViewController, didClickFinishButton button: UIButton) {
        finish(userInfo: "张三")
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func loginViewController(_ viewController: LoginViewController, didClickStartRegisterFlowButton button: UIButton) {
        
        RegisterFlowCoordinator().start(in: viewController) { (result) -> (Void) in
            switch result {
            case let .canceled(error):
                print("取消注册\(error?.localizedDescription ?? "")")
            case let .finished(userInfo):
                print("注册成功\(userInfo ?? ["asdf": 1234])")
            }
        }
    }
}
