//
//  LoginBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

enum UseAppCount: String {
    case login
    case noLogin
}

class LoginBll: NSObject {

    override init() {
        super.init()
    }

    func analyzeUseAppCount() -> UseAppCount {
        if LoginDAL().getUseTime() > 0 {
            return .login
        }
        return .noLogin
    }

    func loginSuccess(_ nickName: String) {
        let userInfo = OTUserInfo()
        userInfo.nickName = nickName
        userInfo.id = "oo1"
        MineBLL().insertUserInto(with: userInfo)
        LoginDAL().setUseTime()
    }

}
