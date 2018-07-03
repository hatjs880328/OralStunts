//
//  MainVCTabVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/28.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class MainVCTabVw: UIView {
    
    var infos: [String] = []
    {
        didSet{
            eachWeight = (APPDelStatic.aWeight) / CGFloat(self.infos.count)
        }
    }
    
    var eachWeight:CGFloat = 0
    
    var scrollLineWeight:CGFloat = 100
    
    let scrollLine = UIView()
    
    var vws: [UILabel] = []
    
    var leftVw: MianVCTabCreateVw!
    
    var rightVw: MiddleBtnVw!
    
    init(frame: CGRect,fatherVw: UIView,topVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(topVw.snp.bottom).offset(5 * APPDelStatic.sizeScale)
        }
        self.setValues(value: ["未分配便签","创建"])
        initVw()
        createVw()
    }
    
    func setValues(value:[String]) {
        self.infos = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initVw() {
        for eachItem in 0 ..< self.infos.count {
            let txt = UILabel()
            txt.text = self.infos[eachItem]
            self.addSubview(txt)
            txt.snp.makeConstraints { (make) in
                make.width.equalTo(eachWeight)
                make.left.equalTo(CGFloat(eachItem) * self.eachWeight)
                make.top.equalTo(0)
                make.height.equalTo(45 * APPDelStatic.sizeScale)
            }
            txt.textAlignment = .center
            txt.font = APPDelStatic.uiFont(with: 13)
            txt.textColor = APPDelStatic.themeColor
            self.vws.append(txt)
            txt.tapActionsGesture {[weak self]() in
                self?.tapActions(index:eachItem)
            }
        }
        self.addSubview(scrollLine)
        scrollLine.snp.makeConstraints { (make) in
            make.width.equalTo(scrollLineWeight)
            make.centerX.equalTo(self.vws.first!.snp.centerX)
            make.height.equalTo(1)
            make.top.equalTo(self.vws.first!.snp.bottom).offset(-1)
        }
        scrollLine.backgroundColor = APPDelStatic.themeColor
    }
    
    func createVw() {
        self.leftVw = MianVCTabCreateVw(frame: CGRect.zero, fatherVw: self, topVw: self.scrollLine)
        self.rightVw = MiddleBtnVw(frame: CGRect.zero, fatherVw: self, topVw: self.scrollLine)
        self.rightVw.alpha = 0
    }
    
    @objc dynamic func tapActions(index: Int) {
        let distance = index == 0 ? self.vws.first!.snp.centerX : self.vws.last!.snp.centerX
        scrollLine.snp.remakeConstraints { (make) in
            make.width.equalTo(scrollLineWeight)
            make.centerX.equalTo(distance)
            make.height.equalTo(1)
            make.top.equalTo(self.vws.first!.snp.bottom).offset(-1)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
        
        if index == 0 {
            leftVwloadData()
            self.leftVw.alpha = 1
            self.rightVw.alpha = 0
        }else{
            self.leftVw.alpha = 0
            self.rightVw.alpha = 1
        }
    }
    
    func leftVwloadData() {
        self.leftVw.vm.loadNonFolderData()
    }
    
    
}
