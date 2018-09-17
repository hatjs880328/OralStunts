//
//  IIBaseWaitAniVw.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/9/14.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation


class IIBaseWaitAniVw: UIView,MONActivityIndicatorViewDelegate {
    
    let indic = MONActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        indic.radius = 5
        indic.internalSpacing = 3
        indic.numberOfCircles = 5
        indic.duration = 1
        //indic.delay = 0.4
        indic.delegate = self
        self.addSubview(indic)
        indic.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX)
        }
        indic.startAnimating()
    }
    
    func stopAni() {
        self.indic.stopAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 等待动画回调
    func activityIndicatorView(_ activityIndicatorView: MONActivityIndicatorView!, circleBackgroundColorAt index: UInt) -> UIColor! {
        return APPDelStatic.themeColor
    }
}
