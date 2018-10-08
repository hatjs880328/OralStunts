//
//  IIModuleCore.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

/**
 
 中转模块任务描述：
 a.功能：将所有模块间的调用通过此模块解耦
 b.实现方式：
 1.所有模块首先需要暴漏出来供其他模块调用的方法-通过本身模块的注册功能实现。
 eg:
 //模块化-模块间通信-模块A注册
 IIModule.getinstance().registerS(XXXModule<ModuleGodFather>)
 注册后，会将暴漏出来的功能的访问路径放到中转模块中
 2.其他模块调用某一个已经注册的功能
 eg:
 let _ = IIModuleCore.getInstance().invokingSomeFunciton(url: "ModuleGodFather/ModuleGodFather/two", params: ["TWO":"MRSHAN"], action: { (DICINFO) in
 print("two_1")
 print(DICINFO)
 })
 调用的时候可以根据注册过的某个URL<ModuleGodFather/ModuleGodFather/two>来搞定。
 如果这个调用方法是有异步[同步]返回值，那么这个返回值实现是通过【被调用方】发送反向通知来搞定，调用方传进去的闭包在接收到反向通知的时候触发。
 3.通知流转方式：
 正向：<notifacationName>
 注册时：注册模块自己监听自己被调用的监听
 调用时：中间模块发送【注册模块】已经监听的各个功能的监听
 反向：<backNotificationName>
 注册时：中间模块监听【注册模块】发过来的反向通知
 调用时：【被调用模块】发送（触发）反向通知
 中间模块监听到之后-触发存储好的闭包
 c.开发人员注意事项：
 1.每个单独的模块需要暴漏出来的方法，都有一定的规则，参考ModuleGodFather
 2.所有参数类型，无论是 in&out 都是类JSON格式数据，可用SwiftyJson解析
 3.如果是为了接续数据方便，可以在中间模块存放一个业务模块 model的镜像 eg:  业务模块：  modelA  中间模块  _modelA
 4.真正开发模块暴露出来的方法 必须  有且只有一个参数
 mrshan - 2017-8-4
 */

class IIModuleCore: NSObject {

    /// 将模块持久在这里
    private var moduleIns: [ModuleGodFather] = []

    /// 将模块和url持久化在这里，并建立对应关系
    private var urlAndModuleDic: Dictionary<String, ModuleGodFather> = [:]

    private override init() {
        super.init()
    }

    private static var shareInstance: IIModuleCore!

    public static func getInstance() -> IIModuleCore {
        if self.shareInstance == nil {
            shareInstance = IIModuleCore()
        }
        return shareInstance
    }

    /// 注册服务
    func registerService(module: ModuleGodFather.Type) {
        let ins = module.init()
        ins.startServices()
        for eachItem in ins.urls {
            self.urlAndModuleDic[eachItem] = ins
        }
    }

    /// 移除某个服务<移除之后，此模块下服务无法再被调用>
    func removeModule(moduleClass: AnyClass) {
        for eachKey in self.urlAndModuleDic.keys {
            if self.urlAndModuleDic[eachKey]!.isKind(of: moduleClass) {
                self.urlAndModuleDic.removeValue(forKey: eachKey)
            }
        }
    }

    /// 获取某个模块下所有的ruls
    func getUrls(with: AnyClass) -> [String]? {
        for eachKey in self.urlAndModuleDic.keys {
            if self.urlAndModuleDic[eachKey]!.isKind(of: with) {
                return self.urlAndModuleDic[eachKey]?.urls
            }
        }
        print("请问-你的类集成了ModuleGodFather否")
        return nil
    }

    /// 根据URL调用某个方法[此方法无需返回值其他module处理结果放到callback中]
    /// 基本数据类型-int,double,float,bool,cgfloat不能作为返回值
    /// - Parameter url: 通知名字
    @discardableResult
    public func invokingSomeFunciton(url: String, params: [String: Any]?, action:(@convention(block)(_ info: Any)->Void)?)->Any? {
        var paraChange = [String: Any]()
        if params != nil {
            paraChange[IIModulefunctionParamsKey] = params
        }
        if action != nil {
            paraChange[IIModulecallBackKey] = action!
        }
        let module = self.getModule(with: url)
        if module == nil {
            print("请问-你这个服务注册了否")
            return nil
        }
        let obj = module!.exeOneFunction(notiName: url, params: paraChange)
        if obj == nil { return nil }

        return obj!.takeUnretainedValue()
    }

    /// 根据调用的路由，获取module,可能为空
    private func getModule(with url: String) -> ModuleGodFather? {
        return self.urlAndModuleDic[url]
    }

}
