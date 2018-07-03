//
//  HTTPRequestResponseProgress.swift
//  FSZCItem
//
//  Created by MrShan on 16/6/23.
//  Copyright © 2016年 Mrshan. All rights reserved.
//

import Foundation
import UIKit

open class IIHTTPRequestErrorProgress: NSObject {
    
    /// 异常处理
    func errorMsgProgress(_ errorMsgType:ERRORMsgType){
        switch errorMsgType {
        case ERRORMsgType.noConnection:
            print("~")
        case ERRORMsgType.timeOut:
            print("~")
        case ERRORMsgType.businessErrorMsg:
            print("~")
        case ERRORMsgType.authError:
            print("~")
        case ERRORMsgType.unknowError:
            print("~")
        default:
            print("~")
        }
    }
    
    /// 请求接口出错需要将信息反馈-先保存后处理
    func errorUpload() {
        
    }
    
    /// 多账户登录的时候
    func moreThanoneUserLoginwithsameoneAPPID() {
       
    }
    
    /// 用户没有权限的时候 跳转到没有权限的界面
    func InsufficientPermissionsProcess(){
        
    }
}

/// 包含错误类型、错误信息
public class ErrorInfo: NSObject {
    
    /// 这里给初值完全是因为让oc能调用到
    public var errorType:ERRORMsgType = ERRORMsgType.unknowError
    
    var errorMsg: String!
    
    /// 第二级错误码 400下的 Error_400_72001一类
    var lv2ErrorCode:String!
    
    init(type:ERRORMsgType,errorMsg: String? = nil)  {
        self.errorType = type
        self.errorMsg = errorMsg
    }
    
    func setLv2ErrorCode(with code: String) {
        self.lv2ErrorCode = code
    }
}
