//
//  ModuleFactory.swift
//  ModuleFactory
//
//  Created by MrShan on 2017/8/3.
//  Copyright © 2017年 JNDZ. All rights reserved.
//

import Foundation


class ModuleFactory:NSObject {

    /// 存储所有注册模型
    private var allRegisterModels:[String:RegisterModel] = [:]

    private override init() {super.init()}

    private static var instance:ModuleFactory!
    
    public static func getInstance()->ModuleFactory {
        if instance == nil {
            self.instance = ModuleFactory()
        }
        return instance
    }

    /// 根据URL调用某个方法[此方法无需返回值其他module处理结果放到callback中]
    ///
    /// - Parameter url: 通知名字
    public func invokingSomeFunciton(url:String,params:[String:Any]?,action:(@convention(block)(_ info:Any)->Void)?) {
        var paraChange = [String:Any]()
        if params != nil {
            paraChange[IIModulefunctionParamsKey] = params
        }
        if action != nil {
            paraChange[IIModulecallBackKey] = action!
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: url), object: nil, userInfo: paraChange)
    }

    /// 让每个module调用，注册服务用,同时接受每一个服务发出来的通知<backNotification>
    ///
    /// - Parameter model: registermodels
    public func registerFunction(model:[RegisterModel]) {
        for eachItem in model {
            self.allRegisterModels [eachItem.notifacationName] = eachItem
        }
    }

}


