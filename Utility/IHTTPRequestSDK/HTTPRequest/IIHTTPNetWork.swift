//
//  HTTPRequestAnalyzeNetWork.swift
//  IIAlaSDK
//
//  Created by Noah_Shan on 2018/5/29.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

open class IIHTTPNetWork: NSObject {

    /// 开启监听与设置ping服务器
    @objc open class func startService() {
        self.setPingHost()
        RealReachability.sharedInstance().startNotifier()
    }

    /// 设置ping服务器
    private class func setPingHost() {
        RealReachability.sharedInstance().hostForPing = "www.inspur.com"
        RealReachability.sharedInstance().hostForCheck = "www.baidu.com"
    }

    /// 添加监听-多用在基类中或者工具类中，普通vc可不用
    @objc open class func addObserver(selector: Selector, observer: Any) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name.realReachabilityChanged, object: nil)
    }

    /// 通知执行函数示例
//    - (void)networkChanged:(NSNotification *)notification
//    {
//    RealReachability *reachability = (RealReachability *)notification.object;
//    ReachabilityStatus status = [reachability currentReachabilityStatus];
//    NSLog(@"currentStatus:%@",@(status));
//    }

    /// 返回实时网络连接状态
    @objc open class func getCurrentStatus() -> Bool {
        let status = RealReachability.sharedInstance().currentReachabilityStatus()
        if status == .RealStatusNotReachable {
            return false
        }
        return true
    }

    /// 返回网络连接类型 
    @objc open class func analyzeViaWhichChannel() -> WWANAccessType {
        return RealReachability.sharedInstance().currentWWANtype()
    }

}
