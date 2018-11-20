//
//  APPDelBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class APPDelBLL: NSObject {

    var page: Int = 1

    override init() {
        super.init()
    }

    func createTab() {
        MineDAL().createTabWithModel()
        OTNoteDAL().createTab()
        FolderDAL().createTab()
        insertPreNote()
    }

    /// 预制一条数据，写入过一次不会再次写入
    func insertPreNote() {
        if IICacheManager.getInstance().isContains(key: IICacheStorage().preNoteInsert) {
            return
        }
        IICacheManager.getInstance().saveObj(key: IICacheStorage().preNoteInsert, someThing: NSString(string: "fdsa"))
        let note = OTNoteModel()
        note.id = NSUUID().uuidString
        note.setTitle("👏🏻👏🏻👏🏻开始使用OralStunts", [])
        note.setContexts(createTime: Date(), content: "👏🏻👏🏻👏🏻开始使用OralStunts,详情请查看个人中心得帮助", volumnList: [])
        note.videoUrl.append("")
        NoteLogicBLL().insertNoteInfo(with: note)

    }

    func thridLibInit(del: AppDelegate,options: [UIApplicationLaunchOptionsKey: Any]?) {
        initTheFlyMSC()
        initTheBUGLY()
        initEvernote()
        startNetworkObserver()
        startCPURecognition()
        OTShare.registerShare()
        injection3Init()
        JPushRegister(del: del, options: options)
    }

    /// 激光推送集成
    func JPushRegister(del: AppDelegate,options: [UIApplicationLaunchOptionsKey: Any]?) {
        JPUSHService.setLogOFF()
        let entity = JPUSHRegisterEntity()
        if #available(iOS 12.0, *) {
            entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.sound.rawValue | JPAuthorizationOptions.providesAppNotificationSettings.rawValue)
        } else {
            entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.sound.rawValue)
        }
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: del)
        JPUSHService.setup(withOption: options, appKey: IIBizConfig.jpushKey, channel: "App Store", apsForProduction: true)
        UIApplication.shared.applicationIconBadgeNumber = 0
        if IICacheManager.getInstance().isContains(key: IICacheStorage().isloginApp) {
            JPUSHService.setAlias(MineBLL().getUserInfo().id.replace(find: "-", replaceStr: ""), completion: { (status, alis, flag) in
            }, seq: 9)
        }
    }

    func injection3Init() {
        #if DEBUG
//        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle")?.load()
//        // for tvOS:
//        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/tvOSInjection10.bundle")?.load()
//        // Or for macOS:
//        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/macOSInjection10.bundle")?.load()
        #endif
    }

    func initTheFlyMSC() {
        IFlySetting.showLogcat(false)
        IFlySpeechUtility.createUtility("appid=\(IIBizConfig.iflyKey)")
    }

    func initTheBUGLY() {
        let config = BuglyConfig()
        config.reportLogLevel = .warn
        Bugly.start(withAppId: IIBizConfig.buglyKey, config: config)
    }

    /// 注册印象笔记
    /// https://dev.yinxiang.com/doc/articles/authentication.php
    func initEvernote() {
        ENSession.setSharedSessionConsumerKey(IIBizConfig.evernoteKey, consumerSecret: IIBizConfig.evernoteSecret, optionalHost: ENSessionHostSandbox)
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

    /// 开启GPU & CPU & MEMORY & FPS 监听
    func startCPURecognition() {
        func start() -> Bool {
            WHDebugToolManager.sharedInstance().toggle(with: DebugToolType.all)
            return true
        }
        //assert(start(), "debug模式下才会开启")
    }

    /// siri-useractivity-jumptovc
    func userActivityJumpToNoteCreateVC() {
        let con = NoteContextCreateViewController()
        NoteCreatingBLL.getInstance().progressModelTitle(title: NoteCreatingBLL.getInstance().creatingNoteModel.id, volumeList: [])
        con.hidesBottomBarWhenPushed = true
        con.presentedVcHasNavigation = false
        guard let saltedVc = (UIApplication.shared.keyWindow?.rootViewController as? SaltedFishTabBarVC) else { return }
        (saltedVc.selectedViewController as? UINavigationController)?.pushViewController(con, animated: true)
    }

}
