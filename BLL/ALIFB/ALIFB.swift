//
//  ALIFB.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/8/31.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

class ALIFB: NSObject {
    
    var kitIns = BCFeedbackKit(appKey: IIBizConfig.aliFbKEY, appSecret: IIBizConfig.aliFbSecret)
    
    override init() {
        super.init()
    }
    
    func initSDK() {
        
    }
    
    func setUserNickName(username:String) {
        kitIns?.setUserNick(username)
    }
    
    func openFbVc(nowVw: UIViewController) {
        kitIns?.makeFeedbackViewController(completionBlock: { (vcIns, error) in
            if error == nil && vcIns != nil {
                nowVw.navigationController?.isNavigationBarHidden = false
                vcIns?.hidesBottomBarWhenPushed = true
                vcIns?.closeBlock = { vc in
                    vc?.navigationController?.popViewController(animated: true)
                }
                vcIns?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: APPDelStatic.themeColor]
                nowVw.navigationController?.pushViewController(vcIns!, animated: true)
            }
        })
    }
}
