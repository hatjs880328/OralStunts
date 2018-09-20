//
//  LongPressShowVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/20.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation


/// 长按item显示出来的操作view
class LongPressShowVw: OTBaseVw {
    
    /// 操作按钮数据源-全选包含选中与非选中两个状态，所以有俩图片，其他的第二个图片为空
    var iconsData = [
        ("收藏","water_fall_unlike_icon","water_fall_like_icon"),
        ("移动","water_fall_move_icon",""),
        ("删除","water_fall_delte_icon",""),
        ("全选","water_fall_selectall_icon","water_fall_selectall_de_icon"),
        ("取消","water_fall_cancel_icon","")]
    
    init(frame: CGRect,topVw: UIView,fatherVw: UIView) {
        super.init(frame: frame)
        self.fatherVw = fatherVw
        self.topVw = topVw
        createVw()
        loopCreateIcon()
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.backgroundColor = UIColor.white
        fatherVw?.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.width.equalTo(APPDelStatic.aWeight - 16 * 2)
            make.top.equalTo(topVw!.snp.bottom).offset(0)
            make.height.equalTo(50)
        }
        self.layer.cornerRadius = 4
        self.borderColor = APPDelStatic.lineGray
        self.borderWidth = 0.5
    }
    
    /// 循环创建icon
    func loopCreateIcon() {
        let tupleInfo = self.calculateNumbers()
        for item in 0 ..< self.iconsData.count {
            let iconBtn = UIButton()
            iconBtn.setTitle(self.iconsData[item].0, for: UIControlState.normal)
            iconBtn.setTitleColor(UIColor.gray, for: UIControlState.normal)
            iconBtn.titleLabel?.font = APPDelStatic.uiFont(with: 11)
            iconBtn.titleLabel?.textAlignment = .center
            iconBtn.imageView?.image = UIImage(named: self.iconsData[item].1)
            iconBtn.setImage(UIImage(named: self.iconsData[item].1), for: UIControlState.normal)
            if self.iconsData[item].2 != "" {
                iconBtn.setImage(UIImage(named: self.iconsData[item].2), for: UIControlState.selected)
            }
            iconBtn.setVerticalLabelBottom(3)
            self.addSubview(iconBtn)
            iconBtn.snp.makeConstraints { (make) in
                make.left.equalTo(tupleInfo.leftPadding + CGFloat(item) * (tupleInfo.eachPadding + tupleInfo.eachWeight))
                make.width.equalTo(tupleInfo.eachWeight)
                make.height.equalTo(tupleInfo.eachWeight + 15)
                make.top.equalTo(3)
            }
            iconBtn.tapActionsGesture {[weak self] () in
                self?.innerTapActions(index: item)
            }
        }
    }
    
    /// 计算距离等信息
    func calculateNumbers()->(eachWeight:CGFloat,leftPadding:CGFloat,eachPadding:CGFloat) {
        self.layoutIfNeeded()
        //每个item宽度
        let eachItemWeight = 30
        //第一个距离左边的距离
        let distanceLeft = 20
        let usedDis:CGFloat = CGFloat(distanceLeft * 2 + eachItemWeight * self.iconsData.count)
        let eachItemPadding = ( self.frame.size.width - usedDis ) / CGFloat(self.iconsData.count - 1)
        
        return (30,20,eachItemPadding)
    }
    
    func hideSelf() {
        UIView.animate(withDuration: 1) {
            self.alpha = 0
            self.layoutIfNeeded()
        }
    }
    
    func showSelf() {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1
            self.layoutIfNeeded()
        }, completion: nil)
    }
}


// MARK: - 按钮的事件
extension LongPressShowVw {
    
    func innerTapActions(index:Int) {
        switch index {
        case 0:
            break;
        case 4:
            self.cancel()
        default:
            break;
        }
    }
    
    /// 取消事件
    func cancel() {
        self.hideSelf()
    }
}
