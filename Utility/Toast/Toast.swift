//
//  File.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/8/29.
//  Copyright © 2018 Inspur. All rights reserved.
//
import UIKit
import Foundation

class Toast: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("rush")
    }

    func show(inSome: UIView) {
        self.alpha = 0.8
        inSome.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(25)
        }
        self.backgroundColor = APPDelStatic.themeColor
        self.text = "靠近耳朵播放使用听筒；远离耳朵播放使用扬声器。"
        self.textColor = UIColor.white
        self.textAlignment = .center
        self.font = APPDelStatic.uiFont(with: 15)

        GCDUtils.delayProgress(delayTime: 1) {
            UIView.animate(withDuration: 2, animations: {
                self.alpha = 0
            }, completion: { (_) in
                self.removeFromSuperview()
            })
        }
    }
}
