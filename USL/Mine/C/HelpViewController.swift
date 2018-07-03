//
//  HelpViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/4.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class HelpViewController: IIBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "使用帮助"
        self.navigationController?.isNavigationBarHidden = false
        let vi = APPNoteVw(frame: self.view.frame)
        self.view.addSubview(vi)
        vi.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
