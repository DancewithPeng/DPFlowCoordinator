//
//  RegisterViewController.swift
//  DPFlowCoordinatorExample
//
//  Created by 张鹏 on 2019/8/26.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController {
    
    /// 完成的处理
    var completionHandler: ((String?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonDidClick(_ sender: Any) {
        completionHandler?(nil)
    }
    
    @IBAction func finishButtonDidClick(_ sender: Any) {
        completionHandler?("李四")
    }
}
