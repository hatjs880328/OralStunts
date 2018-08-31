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
        let vi = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        vi.startAnimating()
        vi.frame.size = CGSize(width: 120, height: 120)
        vi.layer.cornerRadius = 6
        vi.center = UIApplication.shared.keyWindow!.center
        vi.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        UIApplication.shared.keyWindow?.addSubview(vi)
        kitIns?.makeFeedbackViewController(completionBlock: { (vcIns, error) in
            if error == nil && vcIns != nil {
                nowVw.navigationController?.isNavigationBarHidden = false
                vcIns?.hidesBottomBarWhenPushed = true
                vcIns?.closeBlock = { vc in
                    vc?.navigationController?.popViewController(animated: true)
                }
                vcIns?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: APPDelStatic.themeColor]
                nowVw.navigationController?.pushViewController(vcIns!, animated: true)
                vi.stopAnimating()
                vi.removeFromSuperview()
            }else{
                //失败
                vi.stopAnimating()
                vi.removeFromSuperview()
            }
        })
    }
}
