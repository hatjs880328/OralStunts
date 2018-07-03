//
//  FeedBackVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/28.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class FeedBackVw: UIView {
    
    var feedTd = UITextView()
    
    var countLb = UILabel()
    
    var uploadBtn = UIButton()
    
    var vm = FeedBackVM()
    
    init(frame: CGRect,fatherVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        initVw()
        initRx()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initVw() {
        self.addSubview(feedTd)
        self.addSubview(uploadBtn)
        
        feedTd.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(25 * APPDelStatic.sizeScale)
            make.height.equalTo(120 * ( APPDelStatic.sizeScale))
        }
        feedTd.font = APPDelStatic.uiFont(with: 12)
        feedTd.layer.cornerRadius = 3
        feedTd.layer.borderColor = UIColor.gray.cgColor
        feedTd.layer.borderWidth = 0.5
        //记录字符个数
        self.addSubview(countLb)
        countLb.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.right.equalTo(-20)
            make.bottom.equalTo(feedTd.snp.bottom).offset(-5 * APPDelStatic.sizeScale)
            make.height.equalTo(15 * ( APPDelStatic.sizeScale))
        }
        countLb.font = APPDelStatic.uiFont(with: 10)
        countLb.textAlignment = .right
        countLb.textColor = APPDelStatic.themeColor
        countLb.text = "0/80"
        
        uploadBtn.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(feedTd.snp.bottom).offset(15 * APPDelStatic.sizeScale)
            make.height.equalTo(40 * ( APPDelStatic.sizeScale))
        }
        uploadBtn.setTitle("感谢您的箴言", for: UIControlState.normal)
        uploadBtn.layer.cornerRadius = 3
        uploadBtn.setTitleColor(APPDelStatic.themeColor, for: UIControlState.normal)
        uploadBtn.titleLabel?.font = APPDelStatic.uiFont(with: 15)
        uploadBtn.layer.borderColor = UIColor.gray.cgColor
        uploadBtn.layer.borderWidth = 0.5
        uploadBtn.isEnabled = false
        uploadBtn.setTitleColor(UIColor.gray, for: UIControlState.normal)
    }
    
    func initRx() {
        let _ = self.feedTd.rx.text.orEmpty.bind(to: self.vm.fieldInput)
        
        let _ = self.vm.fieldOutput.subscribe { [weak self](event) in
            if event.element == nil { return }
            self?.feedTd.text = event.element!.0
            self?.countLb.text = event.element!.1
            self?.uploadBtn.isEnabled = true
            self?.uploadBtn.setTitleColor(APPDelStatic.themeColor, for: UIControlState.normal)
        }
        
        let _ = self.uploadBtn.rx.tap.bind(to: self.vm.btnInput)
        let _ = self.vm.tapOutput.subscribe { [weak self](voidEvent) in
            (self?.viewController() as? FeedBackViewController)?.goBack()
        }
    }
}
