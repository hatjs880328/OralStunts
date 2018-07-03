//
//  CloudMineViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class CloudMineViewController: IIBaseViewController {

    var tabVw:CloudMineTabVw!
    override func viewDidLoad() {
        super.viewDidLoad()
        createVw()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabVw.tabVM.getUserInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createVw() {
        self.title = "我"
        self.view.backgroundColor = APPDelStatic.lightGray
        tabVw = CloudMineTabVw(frame: CGRect.zero, fatherVw: self.view)
    }

}
