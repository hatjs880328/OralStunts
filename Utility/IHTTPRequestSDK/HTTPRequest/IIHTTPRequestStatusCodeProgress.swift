//
//  IIHTTPRequestStatusCodeProgress.swift
//  IIAlaSDK
//
//  Created by Noah_Shan on 2018/5/29.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class HTTPRequestCodeFactory:NSObject {
    func getInstance(response:DataResponse<Any> )->IIHTTPRequestStatusCodeProgress {
        switch response.response!.statusCode {
        case 200:
            return Code200(response: response)//需要继续处理
        case 400:
            return Code400(response: response)//需要继续处理
        case 401:
            return Code401(response: response)//只需要抛出authError
        case 403:
            return Code403(response: response)//只需要抛出unknowerror
        case 500:
            return Code500(response: response)//只需要抛出unknowerror
        default:
            return CodeOthers(response: response)//只需要抛出unknowerror
        }
    }
}

/// 状态码处理父类
class IIHTTPRequestStatusCodeProgress: NSObject {
    
    var code: Int!
    
    var request: URLRequest!
    
    var responseIns: ResponseClass!
    
    var responseData: DataResponse<Any>!
    
    let contentType = "Content-Type"
    
    init(response:DataResponse<Any> ) {
        super.init()
        self.request = response.request!
        self.code = response.response!.statusCode
        self.responseData = response
        self.progress()
    }
    
    func progress() {}
    
    /// progress 200
    func progressContentType(response: DataResponse<Any>)->ResponseClass {
        let contentType = (response.response?.allHeaderFields[self.contentType] as! NSString).replacingOccurrences(of: " ", with: "").lowercased()
        // json response
        if contentType == ResponseContentType.json.rawValue {
            return ResponseFactoary().responseInstance(data: response, responseType: ResponseContentType.json)
        // proto buf response
        }else if contentType == ResponseContentType.protoBuf.rawValue {
            return ResponseFactoary().responseInstance(data: response, responseType: ResponseContentType.protoBuf)
        // html response
        }else{
            return ResponseFactoary().responseInstance(data: response, responseType: ResponseContentType.html)
        }
    }
}

/// otherCode，需要继续处理response.data-json/probuf/string
class CodeOthers: IIHTTPRequestStatusCodeProgress {
    override func progress() {
        self.responseIns = ResponseFactoary().responseInstance(data: self.responseData, responseType: ResponseContentType.html,errorType: ERRORMsgType.unknowError)
    }
}

/// 200，需要继续处理response.data-json/probuf/string
class Code200: IIHTTPRequestStatusCodeProgress {
    override func progress() {
        self.responseIns = self.progressContentType(response: self.responseData)
    }
}

/// 400比较特殊，同200处理方式
class Code400: IIHTTPRequestStatusCodeProgress {
    override func progress() {
        self.responseIns = self.progressContentType(response: self.responseData)
    }
}

/// 401，直接暴露给业务层即可
class Code401: IIHTTPRequestStatusCodeProgress {
    override func progress() {
        self.responseIns = ResponseFactoary().responseInstance(data: self.responseData, responseType: ResponseContentType.html,errorType: ERRORMsgType.authError)
    }
}

/// 403，直接暴露给业务层即可
class Code403: IIHTTPRequestStatusCodeProgress {
    override func progress() {
        self.responseIns = ResponseFactoary().responseInstance(data: self.responseData, responseType: ResponseContentType.html,errorType: ERRORMsgType.unknowError)
    }
}

/// 500，比较特殊，同200处理方式
class Code500: IIHTTPRequestStatusCodeProgress {
    override func progress() {
        self.responseIns = ResponseFactoary().responseInstance(data: self.responseData, responseType: ResponseContentType.html,errorType: ERRORMsgType.unknowError)
    }
}
