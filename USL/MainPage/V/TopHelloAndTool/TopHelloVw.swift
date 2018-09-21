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
            make.left.equalTo(16)
            make.right.equalTo(-16)
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
            make.right.equalTo(0)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        searchBtn.setImage(UIImage(named: "main_page_righttop_icon"), for: UIControlState.normal)
        searchBtn.setImage(UIImage(named: "main_page_righttop_list_icon"), for: UIControlState.selected)
        searchBtn.tapActionsGesture {[weak self] () in
            self?.searchBtnDidSelectAction()
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
    
    func searchBtnDidSelectAction() {
        //之前被选中-右边的瀑布流显示-这一次要返回列表-隐藏toolbar&取消所有选中
        if self.searchBtn.isSelected {
            (self.viewController() as? MianaddViewController)?.tabVw.progressToolVw.hideSelf()
        }
        self.searchBtn.isSelected = !self.searchBtn.isSelected
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name.init("main_page_change_listAndWaterfall"), object: nil, userInfo: nil)
        
    }
}
