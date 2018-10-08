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
                break
            }
        }
    }

    static func share(with: UIView, title: String, subTitle: String, img: String, shareUrl: URL) {
        let anivw = IIBaseWaitAniVw(frame: CGRect.zero)
        with.addSubview(anivw)
        anivw.snp.makeConstraints { (make) in
            make.centerX.equalTo(with.snp.centerX)
            make.centerY.equalTo(with.snp.centerY)
        }
        let shareParams = NSMutableDictionary()
        shareParams.ssdkSetupShareParams(byText: subTitle, images: [UIImage(named: "voice.png")!], url: shareUrl, title: title, type: SSDKContentType.auto)
        shareParams.ssdkEnableUseClientShare()
        let actionSheet = UIAlertController(title: "分享", message: "选择分享平台", preferredStyle: UIAlertControllerStyle.actionSheet)
        let actionEnd = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        actionSheet.addAction(actionEnd)
        GCDUtils.asyncProgress(dispatchLevel: 2, asyncDispathchFunc: {
            //qq
            let actionqq = UIAlertAction(title: "QQ好友", style: UIAlertActionStyle.default) { (_) in
                ShareSDK.share(SSDKPlatformType.typeQQ, parameters: shareParams, onStateChanged: { (state, _, _, _) in
                    OTShare.progressState(state: state)
                })
            }
            actionSheet.addAction(actionqq)
            //qq zone
            let actionQQZone = UIAlertAction(title: "QQ空间", style: UIAlertActionStyle.default) { (_) in
                ShareSDK.share(SSDKPlatformType.subTypeQZone, parameters: shareParams, onStateChanged: { (state, _, _, _) in
                    OTShare.progressState(state: state)
                })
            }
            actionSheet.addAction(actionQQZone)
            //wx
            let actionWX = UIAlertAction(title: "微信好友", style: UIAlertActionStyle.default) { (_) in
                ShareSDK.share(SSDKPlatformType.typeWechat, parameters: shareParams, onStateChanged: { (state, _, _, _) in
                    OTShare.progressState(state: state)
                })
            }
            actionSheet.addAction(actionWX)
            //短信
            let actionSMS = UIAlertAction(title: "短信", style: UIAlertActionStyle.default) { (_) in
                ShareSDK.share(SSDKPlatformType.typeSMS, parameters: shareParams, onStateChanged: { (state, _, _, _) in
                    OTShare.progressState(state: state)
                })
            }
            //actionSheet.addAction(actionSMS)
            //wx time line
            let actionWXTl = UIAlertAction(title: "微信圈子", style: UIAlertActionStyle.default) { (_) in
                ShareSDK.share(SSDKPlatformType.subTypeWechatTimeline, parameters: shareParams, onStateChanged: { (state, _, _, _) in
                    OTShare.progressState(state: state)
                })
            }
            actionSheet.addAction(actionWXTl)
            //weibo
            let actionwb = UIAlertAction(title: "新浪微博", style: UIAlertActionStyle.default) { (_) in
                ShareSDK.share(SSDKPlatformType.typeSinaWeibo, parameters: shareParams, onStateChanged: { (state, _, _, _) in
                    OTShare.progressState(state: state)
                })
            }
            actionSheet.addAction(actionwb)
        }) {
            with.viewController()!.present(actionSheet, animated: true, completion: nil)
            anivw.stopAni()
        }
    }

    static func progressState(state: SSDKResponseState) {
        switch state {
        case .success:
            OTAlertVw().alertShowSingleTitle(titleInfo: "提示", message: "分享成功")
        case .fail:
            OTAlertVw().alertShowSingleTitle(titleInfo: "提示", message: "分享失败")
        case .cancel:
            OTAlertVw().alertShowSingleTitle(titleInfo: "提示", message: "分享取消")
        default:
            break
        }
    }
}
