//
//  MineServiceModule.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


class MineServiceModule: ModuleGodFather {
    
    /// 对其他模块暴露出-是否开启提示信息
    @objc func isShowAlertInfo()->String {
        if MineBLL().getUserInfo().alertHelpInfo == "true" {
            return "true"
        }else{
            return "false"
        }
    }
    
    /// 对外暴露出appnotevw方法
    @objc func getAlertVw(params: [AnyHashable: Any])->UIView {
        let frame = params["frame"] as! CGRect
        let alertVw = APPNoteVw(frame: frame)
        return alertVw
    }
}
