//
//  FeedBackViewController.swift
//  OralStunts
//  feedback
//  Created by Noah_Shan on 2018/5/28.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class FeedBackViewController: IIBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initVw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initVw() {
        self.title = "意见反馈"
        self.navigationController?.isNavigationBarHidden = false
        _ = FeedBackVw(frame: CGRect.zero, fatherVw: self.view)
    }

}
