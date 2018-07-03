//
//  ModuleGodFatherPostBack.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

/// 反向通知
extension ModuleGodFather {
    
    /// 根据[方法名字]，获取当前方法的RegisterModel
    ///
    /// - Parameter functionName: strInfo
    func getBackNotification(functionName:String)->String {
        return (self.allFuncitons["\(moduleURL)\(functionName)"] as! RegisterModel).backNotificationName
    }
    
    /// 其他模块调用此模块的方法时，此方法有返回值，则将返回值通过[通知]发送出去 [将传过来的uuid传回去-for Block]
    ///
    /// - Parameters:
    ///   - backNotificationName: 被调用方法名字的描述
    ///   - backUserinfo: 处理完毕后方法的返回值[hashable : any]
    ///   - oldNotiDic: 被调用方法传入的参数 [hashable : any]
    func postBackNotification(backNotificationName:String,backUserinfo:[String:Any],oldNotiDic:[String:Any]) {
        let backNotiName = self.getBackNotification(functionName: backNotificationName)
        var postDic = backUserinfo
        postDic[self.uuidKeyStr] = oldNotiDic[self.uuidKeyStr]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: backNotiName), object: nil, userInfo: postDic)
    }
    
    /// 回调函数-异步方法的回传方法
    ///
    /// - Parameters:
    ///   - backUserinfo: 需要返回的字典
    ///   - oldNotiDic: 原来传进来的字典
    func backFunction(backUserinfo:[String:Any],oldNotiDic:Any) {
        var oldDic = oldNotiDic as! [String:Any]
        let funcName = NSStringFromSelector(oldDic[eachFunctionISA] as! Selector)
        var methodNum:UInt32 = 0
        let methodlist = class_copyMethodList(getClassType().1, &methodNum)
        for index in 0 ..< numericCast(methodNum) {
            let method:Method = methodlist![index]
            let methodSelector = method_getName(method)
            if "\(methodSelector)".contains(funcName) {
                self.postBackNotification(backNotificationName: "\(methodSelector)", backUserinfo: backUserinfo, oldNotiDic: oldDic)
                return
            }
        }
    }
}
