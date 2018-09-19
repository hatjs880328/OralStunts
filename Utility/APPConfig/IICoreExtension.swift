//
//  IICoreExtension.swift
//  DingTalkCalander
//
//  Created by Noah_Shan on 2018/4/16.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

@objc class APPDelStatic: NSObject {
    
    @objc static let lightGray = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    
    @objc static let lineGray = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
    
    /// rgb(0,150,246) 
    @objc static let dingtalkBlue = UIColor(red: 0/255, green: 101/255, blue: 105/255, alpha: 1)
    
    /// 缩放
   @objc  static let sizeScale = UIScreen.main.bounds.width / 375.0
    
    /// 顶部导状态栏高度
    @objc static var noNaviTopDistance: CGFloat {
        var dis: CGFloat = 0
        dis = UIApplication.shared.statusBarFrame.size.height
        return dis
    }
    
    @objc static var naviTopDistance: CGFloat {
        var dis: CGFloat = 0
        dis = UINavigationBar().frame.size.height
        return dis
    }
    
    /// 根据字号和宽度比例来处理字体
    @objc static func uiFont(with size: CGFloat) ->UIFont {
        return UIFont.systemFont(ofSize:size * sizeScale)
    }
    
    /// 是否是英文
    @objc static var internationalProgress:Bool {
        return false
    }
    
    /// themecolor 0,101,105 [0x006569]
    @objc static let themeColor:UIColor = UIColor(red: 0/255, green: 101/255, blue: 105/255, alpha: 1)
    
    /// voice inside color 0,226,143
    @objc static let voiceInsideColor:UIColor = UIColor(red: 0/255, green: 226/255, blue: 143/255, alpha: 1)
    
    /// screen height
    @objc static let aHeight:CGFloat = UIScreen.main.bounds.size.height
    
    /// screen weight
    @objc static let aWeight: CGFloat = UIScreen.main.bounds.size.width
    
    
}
