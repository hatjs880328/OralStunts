//
//  HTTPRequestExtension.swift
//  IIAlaSDK
//
//  Created by Noah_Shan on 2018/5/29.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


class IIHTTPRequestExtension: NSObject {
    
    /// 添加报文头部信息
    ///
    /// - Returns: 字典
    class func analyzeHTTPHeader(_ header: HTTPHeaders?)->HTTPHeaders {
        if header == nil {
            //return ["Authorization":IMPAccessTokenModel.activeToken().tokenType + " " + IMPAccessTokenModel.activeToken().accessToken]
            return["":""]
        }else{
            let resultHeader = header!
            return resultHeader
        }
    }
    
    /// 处理没有网络情况，并返回是否有网络
    class func progressNoNetWork()->Bool {
        if !IIHTTPNetWork.getCurrentStatus() {
            return false
        }
        return true
    }
}

/// swift中的 dataresponse- 转义到oc中的nsobject子类
class HTTPOCResponse: NSObject {
    
    var ocRequest: URLRequest?
    
    var ocResponse: HTTPURLResponse?
    
    init(request: URLRequest?,response: HTTPURLResponse?) {
        super.init()
        self.ocRequest = request
        self.ocResponse = response
    }
}

/// 为request添加ext-识别其hashvalue
extension Request : Hashable {
    
    public func getHashValue()->Int {
        let createTime = self.startTime
        let url = self.request?.url
        let hashValue = (createTime!.description + url!.absoluteString).hashValue
        
        return hashValue
    }
    
    public var hashValue: Int {
        
        return getHashValue()
    }
    
    public static func == (lhs: Request, rhs: Request) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
