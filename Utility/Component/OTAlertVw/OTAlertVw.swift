//
//  OTAlertVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import SCLAlertView

class OTAlertVw: NSObject {
    
    override init() {
        super.init()
    }
    
    /// 单行文档提示
    func alertShowSingleTitle(titleInfo:String,message:String) {
        let toast = FFToast(toastWithTitle: titleInfo, message: message, iconImage: UIImage(name: "fftoast_info"))
        toast?.toastPosition = .belowStatusBarWithFillet
        toast?.duration = 1.8
        toast?.toastBackgroundColor = APPDelStatic.themeColor
        toast?.show()
    }
    /// 两个按钮的提示
    func alertShowConfirm(title:String,message: String,confirmStr:String,confirmAction:@escaping ()->Void) {
        
        let alertVw = SCLAlertView()
        alertVw.addButton(confirmStr) {
            confirmAction()
        }
        alertVw.showWarning(title, subTitle: message, closeButtonTitle: "取消", timeout: nil, colorStyle: 0xFFD110, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.topToBottom)
        
    }
}
