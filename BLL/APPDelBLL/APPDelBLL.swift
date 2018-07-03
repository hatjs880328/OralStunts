//
//  APPDelBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class APPDelBLL: NSObject {
    
    var page:Int = 1
    
    override init() {
        super.init()
    }
    
    func createTab() {
        MineDAL().createTabWithModel()
        OTNoteDAL().createTab()
        FolderDAL().createTab()
    }
    
    func thridLibInit() {
        initTheFlyMSC()
        initTheBUGLY()
        initEvernote()
        startNetworkObserver()
    }
    
    func initTheFlyMSC() {
        IFlySpeechUtility.createUtility("appid=\(APPDelStatic.iflyKey)")
    }
    
    func initTheBUGLY() {
        let config = BuglyConfig()
        config.reportLogLevel = .warn
        Bugly.start(withAppId: APPDelStatic.buglyKey, config: config)
    }
    
    /// 注册印象笔记
    /// https://dev.yinxiang.com/doc/articles/authentication.php
    func initEvernote() {
        ENSession.setSharedSessionConsumerKey(APPDelStatic.evernoteKey, consumerSecret: APPDelStatic.evernoteSecret, optionalHost: ENSessionHostSandbox)
    }
    
    /// 网络监听服务启动
    func startNetworkObserver() {
        IIHTTPNetWork.startService()
    }
    
    /// 自定义日常上报-默认用来意见反馈
    func reportCustomExp(info: [Any]) {
        var infos = info
        infos.append(MineBLL().getUserInfo().nickName)
        Bugly.reportException(withCategory: 3, name: "用户意见反馈上报", reason: "改进APP体验", callStack: infos, extraInfo: [:], terminateApp: false)
    }
    
}
