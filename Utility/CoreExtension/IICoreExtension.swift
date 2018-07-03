//
//  IICoreExtension.swift
//  DingTalkCalander
//
//  Created by Noah_Shan on 2018/4/16.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class APPDelStatic {
    
    /// 计算文字宽度
    ///
    /// - Parameters:
    ///   - text: text
    ///   - font: font
    /// - Returns: 宽度
    class func textLength(text:String,font:UIFont) -> CGFloat {
        let attributes = [kCTFontAttributeName:font]
        let leftNameSize = (text as NSString).boundingRect(with: CGSize(width:1000,height:25), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes as [NSAttributedStringKey : Any], context: nil)
        return leftNameSize.width + 5
    }
    
    static let lightGray = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    
    /// rgb(0,150,246) 
    static let dingtalkBlue = UIColor(red: 0/255, green: 101/255, blue: 105/255, alpha: 1)
    
    /// 缩放
    static let sizeScale = UIScreen.main.bounds.width / 375.0
    
    /// 顶部导状态栏高度
    static var noNaviTopDistance: CGFloat {
        var dis: CGFloat = 0
        dis = UIApplication.shared.statusBarFrame.size.height
        return dis
    }
    
    static var naviTopDistance: CGFloat {
        var dis: CGFloat = 0
        dis = UINavigationBar().frame.size.height
        return dis
    }
    
    /// 根据字号和宽度比例来处理字体
    static func uiFont(with size: CGFloat) ->UIFont {
        return UIFont.systemFont(ofSize:size * sizeScale)
    }
    
    /// 是否是英文
    static var internationalProgress:Bool {
        return false
    }
    
    /// themecolor 0,101,105
    static let themeColor:UIColor = UIColor(red: 0/255, green: 101/255, blue: 105/255, alpha: 1)
    
    /// voice inside color 0,226,143
    static let voiceInsideColor:UIColor = UIColor(red: 0/255, green: 226/255, blue: 143/255, alpha: 1)
    
    /// screen height
    static let aHeight:CGFloat = UIScreen.main.bounds.size.height
    
    /// screen weight
    static let aWeight: CGFloat = UIScreen.main.bounds.size.width
    
    static let iflyKey:String = "5b037347"
    
    static let buglyKey: String = "298276f75d"
    
    static let evernoteKey: String = "451145552"
    
    static let evernoteSecret: String = "2f221433eca9261b"
    
    /// 沙盒：https://sandbox.evernote.com/
    /// 生产：https://app.yinxiang.com/
    static let evernoteAPIHost: String = "https://sandbox.evernote.com/"
}
