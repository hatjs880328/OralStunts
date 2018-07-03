
//
//  AlamofireDatatool.swift
//  DataPresistenceLayer
//
//  Created by MrShan on 16/6/13.
//  Copyright © 2016年 Mrshan. All rights reserved.
//

import Foundation

/*
 思路走一波：
 
 TODO:
 将网络请求封装到此core中
 1.网络请求 ✅
 2.数据上传 ❎
 3.数据下载 ❎
 4.网络实时监控与实时状态获取core ✅
 
 FEATURE:
 
 目前处理方式：
 1.首先处理网络无连接与网络连接超时状态-response.result.isFail
 2.经过第一步确认有返回值，既response-result是有值的，此时处理code[200~300,300~500]
 3.经过第二步处理后在分析contenttype,分为 text/plain & application/json; charset=utf-8 & text/html
 4.根据第二步中的code和第三步中的type一起来分析数据，将server-code 和  businessCode 都放到 errorInfo中抛出给业务方
 *5.错误处理类：HTTPRequestErrorProgress此处与当前APP业务有耦合，为了方便统一处理抛出的errCode[401-需要重新请求token]
 
 ErrorInfo细节：
 1.网络无连接 .noConnection
 2.网络超时  .timeOut
 3.业务错误码，接口返回了错误数据eg. ["errCode":"-3","msg":"未将对象引用指向对象实例","errorLvl":"3"]   .businessErrorMsg
 4.认证错误 .authError
 5.其他统一处理提示[服务器异常]错误 .unknowError
 */


open class IIHTTPRequest: NSObject {
    
    override private init() { super.init() }
    
    /// 静态网络请求-优先判断网络状态
    ///
    /// - Parameters:
    ///   - url: URL<String>
    ///   - params: 参数
    ///   - header: header
    ///   - successAction: success action <ResponseClass>
    ///   - errorAction: error action <ErrorInfo>
    @objc open class func startRequest(method:IIHTTPMethod,url:String, params:[String:Any]?,header:[String : String]? = nil,successAction:@escaping (_ response:ResponseClass)->Void,errorAction:@escaping (_ errorType:ErrorInfo)->Void) {
        if !IIHTTPRequestExtension.progressNoNetWork() {
            errorAction(ErrorInfo(type: ERRORMsgType.noConnection))
            return
        }
        let httpHeader = IIHTTPRequestExtension.analyzeHTTPHeader(header)
        let httpMethod = method.changeToAlaMethod()
        let _ = request(url, method: httpMethod, parameters: params, encoding: URLEncoding(), headers: httpHeader).responseJSON { (response) in
            let resultResponse = progressResponse(response: response)
            if resultResponse.errorValue == nil {
                successAction(resultResponse)
            }else{
                IIHTTPRequestErrorProgress().errorMsgProgress(resultResponse.errorValue.errorType)
                errorAction(resultResponse.errorValue)
            }
        }
    }
    
    /// 处理返回数据<无需判断response.issuccess & fail 因为无论失败与否都需要判定code>
    class private func progressResponse(response: DataResponse<Any>)->ResponseClass {
        // time out & no connection & unknow
        if let errorInfo = response.result.error as NSError? {
            if errorInfo.code == -1001 || errorInfo.code == -1003 {
                return ResponseFactoary().responseInstance(data: response, responseType: ResponseContentType.html,errorType: ERRORMsgType.timeOut)
            }
            if errorInfo.code == -1009 {
                return ResponseFactoary().responseInstance(data: response, responseType: ResponseContentType.html,errorType: ERRORMsgType.noConnection)
            }
        }
        // unknow - 其他的失败都是unknow
        if response.response?.statusCode == nil {
            return ResponseFactoary().responseInstance(data: response, responseType: ResponseContentType.html,errorType: ERRORMsgType.unknowError)
        }
        // progress code
        let codeIns = HTTPRequestCodeFactory().getInstance(response: response)
        return codeIns.responseIns
    }
}
