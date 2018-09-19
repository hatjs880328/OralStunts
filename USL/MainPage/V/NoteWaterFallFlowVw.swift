//
//  NoteWaterFallFlowViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/19.
//  Copyright © 2018 Inspur. All rights reserved.
//

import UIKit

/// 首页-瀑布流布局
class NoteWaterFallFlowVw: UIView {
    
    var topVw: UIView?
    
    var fatherVw: UIView?
    
    var tabVw: UIScrollView?
    
    var vm: NoteWaterFallVM?
    
    init(frame: CGRect,topVw: UIView,fatherVw: UIView) {
        super.init(frame:frame)
        self.topVw = topVw
        self.fatherVw = fatherVw
        createVw()
        createVM()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVM() {
        self.vm = NoteWaterFallVM()
        self.vm?.addNewDataAction = {[weak self] () in
            if self == nil { return }
            
        }
    }
    
    func createVw() {
        //self
        self.fatherVw?.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(self.topVw!.snp.bottom).offset(10 * APPDelStatic.sizeScale)
        }
        //tab
        self.tabVw = UICollectionView()
        self.tabVw?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        })
        self.tabVw?.delegate = self
    }

}

extension NoteWaterFallFlowVw:UIScrollViewDelegate {
    
    func add10Items() {
        
    }
}
