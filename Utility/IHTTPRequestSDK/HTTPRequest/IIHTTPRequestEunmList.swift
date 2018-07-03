//
//  HTTPRequestEunmList.swift
//  FSZCItem
//
//  Created by MrShan on 16/6/23.
//  Copyright © 2016年 Mrshan. All rights reserved.
//

import Foundation

/// response header content-type
public enum ResponseContentType:String {
    case json = "application/json;charset=utf-8"
    case html = "text/html"
    case protoBuf = "text/plain"
}

/// http request method
@objc public enum IIHTTPMethod: Int {
    case options
    case get
    case head
    case post
    case put
    case patch
    case delete
    case trace
    case connect
    
    func changeToAlaMethod()->HTTPMethod {
        switch self {
        case .options:
            return HTTPMethod.options
        case .get:
            return HTTPMethod.get
        case .head:
            return HTTPMethod.head
        case .post:
            return HTTPMethod.post
        case .put:
            return HTTPMethod.put
        case .patch:
            return HTTPMethod.patch
        case .delete:
            return HTTPMethod.delete
        case .trace:
            return HTTPMethod.trace
        case .connect:
            return HTTPMethod.connect
        }
    }
}

/**
 网络接口返回数据错误处理枚举[oc无法桥接swift枚举，所以处理成类]
 
 - noConnection:                   没有网络
 - timeOut:                        网络请求超时
 - authError:                      权限错误
 - businessErrorMsg:               返回了业务错误信息eg,["errCode":"-3","msg":"未将对象引用指向对象实例","errorLvl":"3"]
 - unknowError:                    nginx返回错误码不做处理
 */
@objc public enum ERRORMsgType:Int {
    case noConnection
    case timeOut
    case businessErrorMsg
    case authError
    case unknowError
}
