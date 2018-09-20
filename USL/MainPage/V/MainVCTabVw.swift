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
    
    var searchVw: OTSearchVw!
    
    var leftVw: MianVCTabCreateVw!
    
    var rightVw: NoteWaterFallFlowVw!
    
    var topVw: UIView?
    
    init(frame: CGRect,fatherVw: UIView,topVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.topVw = topVw
        self.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(topVw.snp.bottom).offset(5 * APPDelStatic.sizeScale)
        }
        self.setValues(value: ["最新","新建"])
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeUI(noti:)), name: NSNotification.Name.init("main_page_change_listAndWaterfall"), object: nil)
        createVw()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setValues(value:[String]) {
        self.infos = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        searchVw = OTSearchVw(frame: CGRect.zero, fatherVw: self, topVw: self.topVw!,jumpOrUse:true)
        searchVw.snp.updateConstraints { (make) in
            make.top.equalTo(topVw!.snp.bottom)
        }
        self.leftVw = MianVCTabCreateVw(frame: CGRect.zero, fatherVw: self, topVw: self.searchVw)
        self.rightVw = NoteWaterFallFlowVw(frame: CGRect.zero, topVw: self.searchVw, fatherVw: self)
        self.rightVw.alpha = 0
    }
    
    func leftVwloadData() {
        self.leftVw.vm.loadNonFolderData()
        self.rightVw.vm?.getWaterFallData()
    }
    
    @objc func changeUI(noti: Notification) {
        if leftVw.alpha == 0.0 {
            self.leftVw.alpha = 1
            self.rightVw.alpha = 0
        }else{
            self.leftVw.alpha = 0
            self.rightVw.alpha = 1
        }
    }
    
}
