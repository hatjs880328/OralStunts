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
    @objc func getAlertVw(params: [AnyHashable: Any])->UIView? {
        let frame = params["frame"] as! CGRect
        //判定说明-当fathervwframe & snp都为nil或者=0时，subview使用了snp就会报异常
        if frame.size.width == 0 { return nil }
        let alertVw = APPListEmptyVw(frame: frame)
        return alertVw
    }
}
