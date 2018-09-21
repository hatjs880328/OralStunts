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
    
    var tabVw: UICollectionView?
    
    var vm: SearchVCTabVM?
    
    var waterFallLO: XRWaterfallLayout?
    
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
        self.vm = (self.superview as! MainVCTabVw).vm
        self.vm?.addNewDataAction = {[weak self] () in
            if self == nil { return }
            self?.tabVw?.progressNodataAndLoadingBeforeReloaddata()
            //关闭layer隐式动画，防止刷新动画怪异
            //CATransaction.setDisableActions(true)
            self?.tabVw?.reloadData()
        }
    }
    
    func createVw() {
        //self
        self.backgroundColor = UIColor.white
        self.fatherVw?.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(self.topVw!.snp.bottom).offset(10 * APPDelStatic.sizeScale)
        }
        //water-layout
        self.waterFallLO = XRWaterfallLayout(columnCount: 2)
        self.waterFallLO?.setColumnSpacing(10, rowSpacing: 10, sectionInset: UIEdgeInsetsMake(10, 10, 10, 10))
        self.waterFallLO?.delegate = self
        //tab
        self.tabVw = UICollectionView(frame: CGRect.zero, collectionViewLayout: waterFallLO!)
        self.tabVw?.backgroundColor = UIColor.white
        self.tabVw?.register(NoteWaterFallFlowCell.self, forCellWithReuseIdentifier: "reuseWaterFallCell")
        self.addSubview(tabVw!)
        self.tabVw?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        })
        self.tabVw?.delegate = self
        self.tabVw?.dataSource = self
    }
    
    /// 长按事件
    func longPressAction(index:IndexPath,likeOrNot:Bool) {
        self.vm?.selectOneItem(with: index)
        if let superVw = self.superview as? MainVCTabVw {
            superVw.progressToolVw.showSelf(like: likeOrNot)
        }
    }

}

extension NoteWaterFallFlowVw:UICollectionViewDataSource,UICollectionViewDelegate,XRWaterfallLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm!.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseWaterFallCell", for: indexPath) as? NoteWaterFallFlowCell
        if cell == nil {
            cell = NoteWaterFallFlowCell(frame: CGRect.zero)
        }else{
            cell!.removeSubTitle()
        }
        let dataModel = self.vm!.getData(with: indexPath)
        cell?.setData(note: dataModel, indexPath: indexPath)
        cell?.longpressAction = { [weak self] () in
            self?.longPressAction(index:indexPath,likeOrNot: dataModel.isLike)
        }
        return cell!
    }
    
    func waterfallLayout(_ waterfallLayout: XRWaterfallLayout!, itemHeightForWidth itemWidth: CGFloat, at indexPath: IndexPath!) -> CGFloat {
        return self.vm!.getData(with: indexPath).waterFallHeight
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let con = self.vm!.didSelectedOneItemAction(indexPath: indexPath)
        if con == nil { return }
        self.viewController()?.navigationController?.pushViewController(con!, animated: true)
    }
    
}
