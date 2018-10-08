//
//  ModuleGodFather.swift
//  ModuleFactory
//
//  Created by MrShan on 2017/8/3.
//  Copyright © 2017年 JNDZ. All rights reserved.
//

import Foundation

///  所有module的父类-生命周期与服务启动
class ModuleGodFather: NSObject {

    /// 所有的监听key
    var allFuncitons = NSMutableDictionary()

    /// 此为注册时监听的前半部分
    var moduleURL: String = ""

    /// 此为注册时反向监听的前半部分
    var backModuleURL: String = ""

    /// 输过来的uuid
    var uuidKeyStr: String = "blockUUID"

    /// 用来传递每个方法真正的selector的名字
    var eachFunctionISA: String = "_moduleFactory_selectorDIC"

    /// 当前模块暴露出来的所有url
    var urls: [String] = []

    required override init() {
         super.init()
    }

    /// 开启服务--只有此方法可以被调用到
    public func startServices() {
        setModuleURLAndBackurl()
        registerFunctions()
    }

}
