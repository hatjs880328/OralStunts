//
//  TopHelloVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class TopHelloVw: UIView {
    
    let helloLb = UILabel()
    
    let vm = TopHelloVM()
    
    init(frame: CGRect,fatherVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.top.equalTo(APPDelStatic.noNaviTopDistance)
            make.left.equalTo(18)
            make.width.equalTo(250)
            make.height.equalTo(80)
        }
        self.createVw()
        self.createRX()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        
        self.addSubview(helloLb)
        helloLb.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        helloLb.text = MineBLL().getUserInfo().nickName
        helloLb.font = APPDelStatic.uiFont(with: 30)
        helloLb.textColor = APPDelStatic.themeColor
    }
    
    func createRX() {
        let _ = self.vm.outPut.subscribe { [weak self](event) in
            if event.element == nil { return }
            self?.helloLb.text = event.element!
        }
    }
}
