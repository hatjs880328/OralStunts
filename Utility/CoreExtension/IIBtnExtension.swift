//
//  IIBtnExtension.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/20.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation


extension UIButton{
    /**
     设置图片和标题垂直放置 标题在下
     必须设定：标题
     图片 非背景图，图片必须以UIImage(named: )方式设定 否则将找不到
     图片大小与真实比例相同，非压缩 若图片太大则不可以
     
     - parameter imgTextDistance: 图片和文字的间距
     */
    public func setVerticalLabelBottom(_ imgTextDistance:CGFloat){
        let imgWidth = self.imageView?.image?.size.width ?? 0
        let imgHeight = self.imageView?.image?.size.height ?? 0
        let textSize = NSString(string: self.titleLabel!.text!).size(withAttributes: [NSAttributedStringKey.font : self.titleLabel!.font])
        
        //        let textWitdh = textSize.width
        let textHeight = textSize.height
        var interval:CGFloat! // distance between the whole image title part and button
        
        var titleOffsetX:CGFloat! // horizontal offset of title
        var titleOffsetY:CGFloat! // vertical offset of title
        
        self.imageView?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self.snp.centerY).offset(-(textHeight+imgTextDistance)/2);
            make.centerX.equalTo(self.snp.centerX).offset(0);
            make.width.equalTo(imgWidth);
            make.height.equalTo(imgHeight);
        })
        interval = CGFloat(imgHeight) + CGFloat(imgTextDistance)
        titleOffsetX = CGFloat(-imgWidth)
        titleOffsetY = interval;
        self.titleEdgeInsets = UIEdgeInsetsMake(titleOffsetY, titleOffsetX, 0, 0)
        
    }
    
    /**
     设置图片和标题垂直放置 标题在上
     必须设定：标题
     图片 非背景图，图片必须以UIImage(named: )方式设定 否则将找不到
     图片大小与真实比例相同，非压缩 若图片太大则不可以
     
     - parameter imgTextDistance: 图片和文字的间距
     */
    public func setVerticalLabelTop(_ imgTextDistance:CGFloat){
        let imgWidth = self.imageView?.image?.size.width ?? 0
        let imgHeight = self.imageView?.image?.size.height ?? 0
        let textSize = NSString(string: self.titleLabel!.text!).size(withAttributes: [NSAttributedStringKey.font : self.titleLabel!.font])
        
        //        let textWitdh = textSize.width
        let textHeight = textSize.height
        var interval:CGFloat! // distance between the whole image title part and button
        
        var titleOffsetX:CGFloat! // horizontal offset of title
        var titleOffsetY:CGFloat! // vertical offset of title
        
        self.imageView?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self.snp.centerY).offset((textHeight+imgTextDistance)/2);
            make.centerX.equalTo(self.snp.centerX).offset(0);
            make.width.equalTo(imgWidth);
            make.height.equalTo(imgHeight);
        })
        interval = CGFloat(-imgHeight) - CGFloat(imgTextDistance)
        titleOffsetX = CGFloat(-imgWidth)
        titleOffsetY = interval;
        self.titleEdgeInsets = UIEdgeInsetsMake(titleOffsetY, titleOffsetX, 0, 0)
        
    }
    
    /**
     设置图片和标题水平放置 标题在左
     必须设定：标题
     图片 非背景图，图片必须以UIImage(named: )方式设定 否则将找不到
     图片大小与真实比例相同，非压缩 若图片太大则不可以
     
     - parameter imgTextDistance: 图片和文字的间距
     */
    public func setHorizontalLabelLeft(_ imgTextDistance:CGFloat){
        
        let imgWidth = self.imageView?.image?.size.width ?? 0
        let imgHeight = self.imageView?.image?.size.height ?? 0
        let textSize = NSString(string: self.titleLabel!.text!).size(withAttributes: [NSAttributedStringKey.font : self.titleLabel!.font])
        let textWitdh = textSize.width
        //        let textHeight = textSize.height
        var interval:CGFloat! // distance between the whole image title part and button
        var titleOffsetX:CGFloat! // horizontal offset of title
        var titleOffsetY:CGFloat! // vertical offset of title
        
        self.imageView?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self.snp.centerY).offset(0);
            make.centerX.equalTo(self.snp.centerX).offset((textWitdh + imgTextDistance)/2);
            make.width.equalTo(imgWidth);
            make.height.equalTo(imgHeight);
        })
        interval = self.imageView!.frame.origin.x - imgTextDistance-textWitdh - imgWidth * 2;
        titleOffsetX = interval
        titleOffsetY = 0;
        self.titleEdgeInsets = UIEdgeInsetsMake(titleOffsetY, titleOffsetX, 0, 0)
    }
}
