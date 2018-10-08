//
//  MinePersonalTabVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/24.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class MinePersonalTabVM: IIBaseVM {

    var cellInfos = [("意见反馈", "editInfo.png"), ("我喜欢的", "like.png"), ("关于我们", "aboutUs.png"), ("设置", "setting.png")] {
        didSet {
            if self.reloadAction == nil { return }
            self.reloadAction()
        }
    }

    var reloadAction: (() -> Void )!

    override init() {
        super.init()
    }

    func getInfo(with index: IndexPath) ->(title: String, pic: String) {
        return self.cellInfos[index.row]
    }

    func jump(index: IndexPath) -> UIViewController {
        if index.row == 2 {
            let con = MineAboutUSViewController()
            con.hidesBottomBarWhenPushed = true
            return con
        } else if index.row == 0 {
            let con = HelpViewController()
            con.hidesBottomBarWhenPushed = true
            return con
        } else if index.row == 1 {
            let con = MineFavViewController()
            con.hidesBottomBarWhenPushed = true
            return con
        } else {
            let con = SettingViewController()
            con.hidesBottomBarWhenPushed = true
            return con
        }
    }
}
