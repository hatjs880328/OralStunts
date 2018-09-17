//
//  OTShare.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/17.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

/*
 分享中间件开发
 */
class OTShare: NSObject {
    override init() {
        super.init()
    }
    
    /// 注册&设置分发平台
    static func registerShare() {
        ShareSDK.registerActivePlatforms([
            SSDKPlatformType.typeSinaWeibo.rawValue,
            SSDKPlatformType.typeWechat.rawValue,
            SSDKPlatformType.subTypeWechatTimeline.rawValue,
            SSDKPlatformType.typeSMS.rawValue,
            SSDKPlatformType.typeCopy.rawValue,
            SSDKPlatformType.typeQQ.rawValue,
            SSDKPlatformType.typeSMS.rawValue], onImport: { (platForm) in
                switch platForm {
                case .typeWechat:
                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                case .typeQQ:
                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                case .typeSinaWeibo:
                    ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
                default:
                    break
                }
        }) { (platForm, appInfo) in
            switch platForm {
            case .typeSinaWeibo:
                appInfo?.ssdkSetupSinaWeibo(byAppKey: "568898243", appSecret: "38a4f8204cc784f81f9f0daaf31e02e3", redirectUri: "http://www.sharesdk.cn", authType: SSDKAuthTypeBoth)
            case .typeWechat:
                appInfo?.ssdkSetupWeChat(byAppId: "wx4868b35061f87885", appSecret: "64020361b8ec4c99936c0e3999a9f249")
            case .typeQQ:
                appInfo?.ssdkSetupQQ(byAppId: "100371282", appKey: "aed9b0303e3ed1e27bae87c33761161d", authType: SSDKAuthTypeBoth)
            default:
                break;
            }
        }
    }
    
    func share(title: String,subTitle:String,img:String,shareUrl: URL) {
        let shareParams = NSMutableDictionary()
        shareParams.ssdkSetupShareParams(byText: subTitle, images: [UIImage(named:"voice.png")!], url: shareUrl, title: title, type: SSDKContentType.auto)
        shareParams.ssdkEnableUseClientShare()
        ShareSDK.showShareActionSheet(nil, items: nil, shareParams: shareParams) { (state, platForm, userData, content, error, end) in
            switch state {
            case .success:
                OTAlertVw().alertShowSingleTitle(titleInfo: "提示", message: "分享成功")
            case .fail:
                OTAlertVw().alertShowSingleTitle(titleInfo: "提示", message: "分享失败")
            case .cancel:
                OTAlertVw().alertShowSingleTitle(titleInfo: "提示", message: "分享取消")
            default:
                break;
            }
        }
        
    }
}
