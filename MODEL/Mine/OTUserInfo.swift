//
//  OTUserInfo.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/17..
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class OTUserInfo: NSObject, Codable {

    /// primary key
    var id: String = String()
    /// nick name
    var nickName: String = String()
    /// create time
    var createTime: String = Date().dateToString("yyyy-MM-dd HH:mm:ss")
    /// noteInfo
    var noteInfo: String = "快乐一签。"
    /// gender
    var gender: String = "boy"
    /// if alertHelpInfo-default is yes
    var alertHelpInfo = "true"

}
