//
//  ModuleGodFatherLifeCircle.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

/// 接受通知，并吊起响应方法
extension ModuleGodFather {
    
    /// 根据通知名称来判断应该执行哪个方法，可用[运行时perform]
    ///
    /// - Parameters:
    ///   - notiName: 通知名称
    ///   - params: 执行方法需要的参数 [这个字典包含俩参数，第一个是参数集合，第二个是callbackAction]
    func exeOneFunction(notiName:String,params:[AnyHashable:Any])->Unmanaged<AnyObject>? {
        let selector = (self.allFuncitons[notiName] as! RegisterModel).selectorInfo
        var functionParams:[AnyHashable:Any]!
        var functionCallback: (@convention(block)(_ info: Any)->Void)!
        if params[IIModulefunctionParamsKey] != nil {
            functionParams = params[IIModulefunctionParamsKey] as! [AnyHashable:Any]
        }
        if params[IIModulecallBackKey] != nil {
            functionCallback = params[IIModulecallBackKey] as! (@convention(block)(_ info: Any)->Void)
        }
        //调用oc的方法-未能完美解决<基本数据类型如INT>，所以返回值丢到closure里面
        //let rush = IIModuleInvocation().invokingMethod(self, selector: selector, params: ["a":4])
        //调用方法
        if functionCallback != nil && functionParams != nil {
            return self.perform(selector, with: functionParams, with: functionCallback)
        }else if functionCallback == nil && functionParams != nil {
            return self.perform(selector, with: functionParams)
        }else if functionCallback != nil && functionParams == nil{
            return self.perform(selector, with: functionCallback)
        }else{
            return self.perform(selector)
        }
    }
    
}
