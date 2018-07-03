//
//  CloudMinePicShow.swift
//  OralStunts
//  图片查看view
//  Created by Noah_Shan on 2018/6/8.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


class CloudMinePicShow: UIWindow {
    
    var imgVw: UIImageView!
    init(frame: CGRect,imageUrl: URL?) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = UIColor.black
        self.makeKeyAndVisible()
        self.windowLevel = UIWindowLevelStatusBar
        self.isHidden = false
        createVw(url: imageUrl)
    }
    
    func createVw(url: URL?) {
        self.imgVw = UIImageView()
        self.addSubview(imgVw)
        imgVw.sd_setImage(with: url, completed: nil)
        imgVw.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(APPDelStatic.aWeight)
            make.height.equalTo(APPDelStatic.aHeight / 3 * 2)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignKey()
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
