//
//  HTTPRequestFactory.swift
//  FSZCItem
//
//  Created by MrShan on 16/6/23.
//  Copyright © 2016年 Mrshan. All rights reserved.
//

import Foundation

/// 数据处理工厂类
open class ResponseFactoary: NSObject {
    func responseInstance(data: DataResponse<Any>, responseType: ResponseContentType, errorType: ERRORMsgType? = nil) -> ResponseClass {
        if errorType != nil {
            return ResponseERROR(data: data, errorType: errorType!)
        }
        switch responseType {
        case .json:
            return ResponseJSON(data: data)
        case .protoBuf:
            return ResponseProtoBuf(data: data)
        case .html:
            return ResponseHTML(data: data)
        }
    }
}

/// 返回数据类（基类）
open class ResponseClass: NSObject {

    /// 错误 可为nil
    var errorValue: ErrorInfo!

    /// 结果dic 可为nil
    var dicValue: NSDictionary!

    /// 结果arr 可为nil
    var arrValue: NSArray!

    /// 结果string 可为nil
    var strValue: String!

    /// alamofire-response，包含 [request & response]
    var response: DataResponse<Any>! {
        didSet {
            self.ocResponse = HTTPOCResponse(request: response.request, response: response.response)
        }
    }

    var ocResponse: HTTPOCResponse!

    func setData(_ data: DataResponse<Any>) {
        self.response = data
    }

    init(data: DataResponse<Any>, errorType: ERRORMsgType? = nil) {
        super.init()
        if errorType != nil {
            self.errorValue = ErrorInfo(type: errorType!)
        }
        self.setData(data)
    }

    /// 业务逻辑返回错误码+错误信息 true: 是 false: 没返回
    func progressStupidErrmsg(_ data: NSDictionary) -> Bool {
        if data["ErrorType"] != nil || data["errCode"] != nil || data["msg"] != nil {
            let emptyStr = ""
            let errMsg = "\(data["msg"] ?? emptyStr)\(data["Message"] ?? emptyStr)"
            self.errorValue = ErrorInfo(type: ERRORMsgType.businessErrorMsg, errorMsg: errMsg)
            self.errorValue.setLv2ErrorCode(with: "\(data["errCode"] ?? emptyStr)")
            return true
        } else {
            return false
        }
    }
}

/// 返回数据类型-错误类型
open class ResponseERROR: ResponseClass {
    override func setData(_ data: DataResponse<Any>) {
        super.setData(data)
        // 构造方法中已经处理
    }
}

/// 返回数据类型-HTML
open class ResponseHTML: ResponseClass {
    override func setData(_ data: DataResponse<Any>) {
        super.setData(data)
        self.errorValue = ErrorInfo(type: ERRORMsgType.unknowError)
    }
}

/// 返回数据类-JSON
open class ResponseJSON: ResponseClass {
    override func setData(_ data: DataResponse<Any>) {
        super.setData(data)
        if let dicValue = data.value as? NSDictionary {
            if self.progressStupidErrmsg(dicValue) { return }
            self.dicValue = dicValue
            return
        }
        if let arrValue = data.value as? NSArray {
            self.arrValue = arrValue
            return
        }
        //str value
        self.strValue = data.value as! String
        return
    }
}

/// 返回数据类-protobuf <Data>
open class ResponseProtoBuf: ResponseClass {

    override func setData(_ data: DataResponse<Any>) {
        super.setData(data)
    }
}
