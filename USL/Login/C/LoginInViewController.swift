//
//  LoginInViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class LoginInViewController: IIBaseViewController {

    var vw: LoginInVw!
    override func viewDidLoad() {
        super.viewDidLoad()
        createVw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func createVw() {
        self.vw = LoginInVw(frame: .zero, fatherVw: self.view)
    }

    override func viewDidDisappear(_ animated: Bool) {
         self.vw.deinitTimer()
    }

    deinit {
        //print("deinitloginvc")
    }

}
