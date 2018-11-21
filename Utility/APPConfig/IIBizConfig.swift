//
//  IIBizConfig.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/8/31.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

class IIBizConfig: NSObject {

    static let aliFbKEY: String = "25051021"

    static let aliFbSecret: String = "daf54c4783924b6b5146d35245ba595b"

    static let iflyKey: String = "5b037347"

    static let buglyKey: String = "298276f75d"

    static let evernoteKey: String = "451145552"

    static let evernoteSecret: String = "2f221433eca9261b"

    static let jpushKey: String = "1da64fd63bcbce8657782465"

    static let jpushSecret: String = "12a982bb7b46ee52e19a9b85"

    /// 沙盒：https://sandbox.evernote.com/
    /// 生产：https://app.yinxiang.com/
    static var evernoteAPIHost: String {
        #if DEBUG
        return "https://sandbox.evernote.com/"
        #else
        return "https://app.yinxiang.com/"
        #endif
    }
}
