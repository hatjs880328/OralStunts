//
//  MineViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/24.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class MineViewController: IIBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initVw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initVw() {
        self.navigationController?.isNavigationBarHidden = true
        let personInfoVw: MinePersonalInfoVw = MinePersonalInfoVw(frame: CGRect.zero, fatherVw: self.view)
        let _ = MinePersionalTabVw(frame: CGRect.zero, fatherVw: self.view, topVw: personInfoVw)
    }

}
