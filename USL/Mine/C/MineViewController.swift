//
//  MineViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/24.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

@objc class MineViewController: IIBaseViewController {

    var mainTab:MinePersionalTabVw?

    override func viewDidLoad() {
        super.viewDidLoad()
        initVw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    func initVw() {
        let personInfoVw: MinePersonalInfoVw = MinePersonalInfoVw(frame: CGRect.zero, fatherVw: self.view)
        mainTab = MinePersionalTabVw(frame: CGRect.zero, fatherVw: self.view, topVw: personInfoVw)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.mainTab?.aliFBIns.vi?.stopAni()
    }

}
