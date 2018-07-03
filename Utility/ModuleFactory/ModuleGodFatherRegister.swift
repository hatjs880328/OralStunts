//
//  ModuleGodFatherRegister.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

/// 注册服务功能
extension ModuleGodFather {
    
    /// 根据当前类名字，设置 moduleURL & backModuleURL
    func setModuleURLAndBackurl() {
        let className = getClassType().0
        self.moduleURL = className + "/"
        self.backModuleURL = "back" + "/" + self.moduleURL
    }
    
    /// 获取当前类的类名字和 类.type
    ///
    /// - Returns: turpleInfo
    func getClassType()->(String,AnyClass) {
        let className = self.description.components(separatedBy: ":")[0].components(separatedBy: ".")[1]
        let nameSpace =  Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        let cls:AnyClass = NSClassFromString("\(nameSpace).\(className)")!
        return (className,cls)
    }
    
    /// 注册方法
    func registerFunctions() {
        var methodNum:UInt32 = 0
        let methodlist = class_copyMethodList(getClassType().1, &methodNum)
        for index in 0 ..< numericCast(methodNum) {
            let method:Method = methodlist![index]
            let methodSelector = method_getName(method)
            if !"\(methodSelector)".contains("init") && !"\(methodSelector)".contains("startServices") && !"\(methodSelector)".contains("cxx_destruct")
                && !"\(methodSelector)".contains("AnalyzeNetWorkWithNoti"){
                let registone = RegisterModel()
                registone.descriptionD = "\(method_getName(method))"
                registone.notifacationName = "\(moduleURL)\(method_getName(method))"
                registone.backNotificationName = "\(backModuleURL)\(method_getName(method))"
                registone.selectorInfo = method_getName(method)
                self.allFuncitons[registone.notifacationName] = registone
                self.urls.append(registone.notifacationName)
                print("\n\(registone.notifacationName)\n")
            }
        }
    }
    
}
