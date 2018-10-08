//
//  RegisterM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

/// 存储回调函数的key-不对业务方暴露
let IIModulecallBackKey: String = "callBackKey"

/// 存储调用方法参数的key-不对业务方暴露
let IIModulefunctionParamsKey: String = "functionParamsKey"

/// 注册model-通知字段、功能描述、反向通知字段（如果是异步则需要使用），selectorInfo为了动态执行方法使用
class RegisterModel {

    var notifacationName: String = ""

    var descriptionD: String = ""

    var backNotificationName: String = ""

    var selectorInfo: Selector!
}
