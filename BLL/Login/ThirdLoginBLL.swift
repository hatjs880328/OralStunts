//
// Created by Noah_Shan on 2018/6/18.
// Copyright (c) 2018 Inspur. All rights reserved.
//

import Foundation

/// 第三方登陆业务逻辑
class ThirdLoginBLL: NSObject {

    /// 调用auth方法
    func invokingNoteAuth(vc: UIViewController) {
        ENSession.shared.authenticate(with: vc, preferRegistration: false) { (errorInfo) in
            if errorInfo == nil { return }
            OTAlertVw().alertShowSingleTitle(titleInfo: "提醒", message: errorInfo!.localizedDescription)
        }
    }

    /// 获取一个临时token
    func getTemporaryToken() {
        ThirdLoginDAL().getTemporaryToken()
    }

}
