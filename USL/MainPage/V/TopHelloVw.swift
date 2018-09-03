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
    
    let searchBtn = UIButton()
    
    init(frame: CGRect,fatherVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.top.equalTo(APPDelStatic.noNaviTopDistance)
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.height.equalTo(80)
        }
        self.createVw()
        self.createRX()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        searchBtn.setImage(UIImage(named: "search"), for: UIControlState.normal)
        searchBtn.tapActionsGesture {[weak self] () in
            IIModuleCore.getInstance().invokingSomeFunciton(url: "SearchServiceModule/jumpToSearchVCWithParams:", params: ["fromVC":self!.viewController()!], action: nil)
        }
        self.addSubview(helloLb)
        helloLb.snp.makeConstraints { (make) in
            make.right.equalTo(searchBtn.snp.left).offset(-5)
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
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
