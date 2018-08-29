//
//  OTAlertVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class OTAlertVw: NSObject {
    
    override init() {
        super.init()
    }
    
    /// 单行文档提示
    func alertShowSingleTitle(titleInfo:String,message:String,from:UIViewController) {
        let alert = UIAlertController(title: titleInfo, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(cancelAction)
        from.present(alert, animated: true, completion: nil)
    }
    /// 两个按钮的提示
    func alertShowConfirm(title:String,message: String,from: UIViewController,confirmStr:String,confirmAction:@escaping (UIAlertAction)->Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(cancelAction)
        let confirmAction = UIAlertAction(title: confirmStr, style: UIAlertActionStyle.destructive, handler: confirmAction)
        alert.addAction(confirmAction)
        from.present(alert, animated: true, completion: nil)
    }
}
