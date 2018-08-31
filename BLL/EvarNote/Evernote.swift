//
//  Evernote.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/8/31.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation
import EvernoteSDK

/*
 印象笔记帮助类
 文档地址：https://github.com/evernote/evernote-cloud-sdk-ios
 
 
 */
class Evernote: NSObject {
    override init() {
        super.init()
    }
    
    /// 注册服务
    func setupKey() {
        ENSession.setSharedSessionConsumerKey(IIBizConfig.evernoteKey, consumerSecret: IIBizConfig.evernoteSecret, optionalHost: ENSessionHostSandbox)
    }
    
    /// 身份认证
    func authenticationSetup(delegate:UIViewController) {
        ENSession.shared.authenticate(with: delegate, preferRegistration: false) { (errorInfo) in
            if errorInfo != nil {
                //认证失败
            }
        }
    }
}
