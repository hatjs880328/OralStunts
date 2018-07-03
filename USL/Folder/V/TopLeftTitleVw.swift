//
//  TopLeftTitleVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/23.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class TopLeftTitleVw: UIView {
    
    let helloLb = UILabel()
    
    var showTxt: String = ""
    
    init(frame: CGRect,fatherVw: UIView,txt:String) {
        super.init(frame: frame)
        self.showTxt = txt
        fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.top.equalTo(APPDelStatic.noNaviTopDistance)
            make.left.equalTo(18)
            make.width.equalTo(250)
            make.height.equalTo(45)
        }
        self.createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.addSubview(helloLb)
        helloLb.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        helloLb.text = self.showTxt
        helloLb.font = APPDelStatic.uiFont(with: 20)
        helloLb.textColor = APPDelStatic.themeColor
    }
}
