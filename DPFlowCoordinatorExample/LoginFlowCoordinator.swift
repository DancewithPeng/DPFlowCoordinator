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
class LoginFlowCoordinator: FlowCoordinator<LoginFlowCoordinator.Result> {
    
    override func start(at viewController: UIViewController?, completion: CompletionHandler?) {
        super.start(at: viewController, completion: completion)
        showLoginPage()
    }
    
    func showLoginPage() {
        guard let loginPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
        
        loginPage.delegate = self
        baseViewController?.present(loginPage, animated: true, completion: nil)
    }
    
    deinit {
        print("\(self) did deinit!!!")
    }
}

// MARK: - LoginViewControllerDelegate
extension LoginFlowCoordinator: LoginViewControllerDelegate {
    
    func loginViewController(_ viewController: LoginViewController, didClickCancelButton button: UIButton) {
        end(with: .skip)
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func loginViewController(_ viewController: LoginViewController, didClickFinishButton button: UIButton) {
        end(with: .success("张三"))
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func loginViewController(_ viewController: LoginViewController, didClickStartRegisterFlowButton button: UIButton) {
        Task {
            let ret = await RegisterFlowCoordinator().start(at: viewController)
            switch ret {
            case let .success(info):
                print("注册成功\(info)")
            case let .failure(error):
                print("注册失败\(error)")
            }
        }
    }
}

extension LoginFlowCoordinator {
    
    enum Result {
        case skip
        case failure
        case success(String)
    }
}
