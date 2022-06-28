//
//  RegisterFlowCoordinator.swift
//  DPFlowCoordinatorExample
//
//  Created by 张鹏 on 2019/8/26.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation
import DPFlowCoordinator

/// 注册流程
class RegisterFlowCoordinator: FlowCoordinator<RegisterFlowCoordinator.Result> {
    
    override func start(in viewController: UIViewController?, completion: CompletionHandler?) {
        super.start(in: viewController, completion: completion)
        showRegisterPage()
    }
    
    func showRegisterPage() {
        guard let registerPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else {
            return
        }
        
        registerPage.completionHandler = { [weak self] (text) in
            if text == nil {
                self?.baseViewController?.dismiss(animated: true, completion: nil)
                self?.complete(.failure(.wrongInput))
            } else {
                self?.baseViewController?.dismiss(animated: true, completion: nil)
                self?.complete(.success(["1234": 123]))
            }
        }
        
        baseViewController?.present(registerPage, animated: true, completion: nil)
    }
    
    deinit {
        print("\(self) did deinit!!!")
    }
}

extension RegisterFlowCoordinator {
    
    enum Error: Swift.Error {
        case wrongInput
    }
    
    enum Result {
        case success([String: Any])
        case failure(Error)
    }
}

