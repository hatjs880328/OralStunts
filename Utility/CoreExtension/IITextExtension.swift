//
//  IITextExtension.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/8/29.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation


class IITextExtension {
    
    /// 计算文字高度
    ///
    /// - Parameters:
    ///   - text: text
    ///   - font: font
    /// - Returns: 宽度
    class func textLength(text:String,font:UIFont,eachLineWeight:CGFloat) -> CGFloat {
        let attributes = [kCTFontAttributeName:font]
        let txts = text.split(separator: "\n")
        var heightResult:CGFloat = 0
        for eachTxt in txts {
            let leftNameSize = (eachTxt as NSString).boundingRect(with: CGSize(width:1000,height:25), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes as [NSAttributedStringKey : Any], context: nil)
            if leftNameSize.width.truncatingRemainder(dividingBy: eachLineWeight) != 0 {
                let lineNumber = ((leftNameSize.width + 5) / eachLineWeight + 1) * (font.pointSize + 2)
                heightResult += lineNumber
            }else{
                let lineNumber = ((leftNameSize.width + 5) / eachLineWeight) * (font.pointSize + 2)
                heightResult += lineNumber
            }
        }
        return heightResult
    }
    
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
}
