//
//  AppDelegate.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/17.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // xml-ioc service start
        BeanDicCenter.getInstance().startService()
        // sqlite - init
        APPDelBLL().createTab()
        // 3-rd lib init
        APPDelBLL().thridLibInit()
        // aop-nbp service[使用全局监控，这里无需注册]
        AOPNBPCoreManagerCenter.getInstance().startService()
        // moduleSearchService register service
        IIModuleCore.getInstance().registerService(module: SearchServiceModule.self)
        IIModuleCore.getInstance().registerService(module: MineServiceModule.self)
        //BeeHive.shareInstance().registerService(CloudMineIBLL.self, service: CloudMineModule.self)
        //byteCode pile
        IIPitchUtility.getInstance().startService()
        // init vcs
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if LoginBll().analyzeUseAppCount() == .noLogin {
            self.window?.rootViewController = LoginInViewController()
        } else {
            self.window?.rootViewController = SaltedFishTabBarVC()
        }
        self.window?.makeKeyAndVisible()

        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if userActivity.activityType.contains("com.oralstunts.videoDing") {
            APPDelBLL().userActivityJumpToNoteCreateVC()
        }
        return true
    }

}
