//
//  OTSiri.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/29.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation
import UIKit
import IntentsUI
import Intents
import CoreSpotlight

class OTSiri: NSObject {
    
    override init() {
        super.init()
    }
    
    @available(iOS 10.0, *)
    class func videoDing(vi:UIView)->NSUserActivity {
        let activity = NSUserActivity(activityType:"com.oralstunts.videoDing")
        INPreferences.requestSiriAuthorization { (status) in
            switch status {
            case .notDetermined:
                print("用户尚未对该应用程序作出选择")
            case .restricted:
                print("此应用程序无权使用Siri服务")
            case .denied :
                print("用户已明确拒绝此应用程序的授权")
            case .authorized :
                print("用户可以使用此应用程序的授权")
            }
        }
        activity.title="语音便捷打开此APP"
        activity.userInfo = ["speech":"便捷创建"]
        activity.isEligibleForSearch=true
        if #available(iOS 12.0, *) {
            activity.isEligibleForPrediction = true
        } else {
        }
        let attribute = CSSearchableItemAttributeSet()
        let icon = UIImage(named:"note_create_righticon")
        attribute.thumbnailData = UIImagePNGRepresentation(icon!)
        attribute.contentDescription = "你可以说：创建新的便签"
        activity.contentAttributeSet = attribute
        vi.userActivity = activity
        activity.becomeCurrent()
        
        return activity
    }
}
