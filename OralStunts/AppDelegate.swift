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
        APPDelBLL().thridLibInit(del: self, options: launchOptions)
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

extension AppDelegate: JPUSHRegisterDelegate {

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }

    @available(iOS 12.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
        if (notification?.request.trigger != nil) && notification!.request.trigger!.isKind(of: UNPushNotificationTrigger.self) {
            //从通知界面直接进入应用
        }else{
            //从通知设置界面进入应用
        }
    }

    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger != nil && response.notification.request.trigger!.isKind(of: UNPushNotificationTrigger.self) {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler()
    }

    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userinfo = notification.request.content.userInfo
        if notification.request.trigger != nil && notification.request.trigger!.isKind(of: UNPushNotificationTrigger.self) {
            JPUSHService.handleRemoteNotification(userinfo)
        }
        completionHandler!(Int(UNNotificationPresentationOptions.alert.rawValue))
    }
}
