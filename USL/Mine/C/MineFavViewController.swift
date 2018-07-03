//
//  MineFavViewController.swift
//  OralStunts
//  我喜欢列表
//  Created by Noah_Shan on 2018/5/28.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class MineFavViewController: IIBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我喜欢的"
        self.navigationController?.isNavigationBarHidden = false
        let noDoVw = UILabel()
        self.view.addSubview(noDoVw)
        noDoVw.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        noDoVw.text = "敬请期待!"
        noDoVw.textAlignment = .center
        noDoVw.font = APPDelStatic.uiFont(with: 28)
        noDoVw.textColor = APPDelStatic.themeColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
