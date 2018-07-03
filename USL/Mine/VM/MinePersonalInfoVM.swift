//
//  MinePersonalInfoVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/4.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


class MinePersonalInfoVM: IIBaseVM {
    
    override init() {
        super.init()
    }
    
    /// 更改性别-返回图片的名称
    func updateHeadImg()->String {
        if MineBLL().getUserInfo().gender == "boy" {
            MineBLL().updateGender(gender: "girl")
            return "girl.png"
        }else{
            MineBLL().updateGender(gender: "boy")
            return "boy.png"
        }
    }
    
    func getHeadImg()->String {
        if MineBLL().getUserInfo().gender == "boy" { return "boy.png" }
        return "girl.png"
    }
}
