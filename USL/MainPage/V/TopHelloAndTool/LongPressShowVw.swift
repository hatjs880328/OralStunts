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
        ("全选","water_fall_selectall_de_icon","water_fall_selectall_icon"),
        ("取消","water_fall_cancel_icon","")]
    
    var btnArr: [UIButton] = []
    
    init(frame: CGRect,topVw: UIView,fatherVw: UIView) {
        super.init(frame: frame)
        self.fatherVw = fatherVw
        self.topVw = topVw
        createVw()
        loopCreateIcon()
        self.alpha = 0
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeLikeOrNotBySelectedItems), name: NSNotification.Name.init("Progress_tool_changeBySelectoneItem"), object: nil)
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
            btnArr.append(iconBtn)
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
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        }
    }
    
    func showSelf(like:Bool = false) {
        if like {
            self.btnArr.first!.isSelected = true
        }
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1
        }, completion: nil)
    }
}


// MARK: - 按钮的事件
extension LongPressShowVw {
    
    func innerTapActions(index:Int) {
        switch index {
        case 0:
            likeOrNot()
        case 1:
            move()
        case 2:
            self.delete()
        case 3:
            selectAll()
        case 4:
            cancel()
        default:
            break;
        }
    }
    
    /// 取消事件
    func cancel() {
        self.hideSelf()
        if let vw = (self.superview as? MainVCTabVw) {
           vw.vm?.selectAllItems(selectOrDeselect: false)
        }
    }
    
    /// 全选
    func selectAll() {
        if let vw = (self.superview as? MainVCTabVw) {
            if btnArr[3].isSelected {
                vw.vm?.selectAllItems(selectOrDeselect: false)
                btnArr[3].isSelected = false
            }else{
                vw.vm?.selectAllItems(selectOrDeselect: true)
                btnArr[3].isSelected = true
            }
        }
    }
    
    /// 删除
    func delete() {
        self.hideSelf()
        if let vw = (self.superview as? MainVCTabVw) {
            vw.vm?.deleteNotesBySelectedFlag()
        }
    }
    
    /// 移动
    func move() {
        self.hideSelf()
        if let vw = (self.superview as? MainVCTabVw) {
            let con = vw.vm?.moveNoteBySelectedFlag()
            if con == nil { return }
            (self.viewController()?.navigationController)?.pushViewController(con!, animated: true)
        }
    }
    
    /// 收藏与否[有一个必须换，图标就边暗]
    func likeOrNot() {
        if let vw = (self.superview as? MainVCTabVw) {
            vw.vm?.progressLikeOrNot(likeOrNot: !self.btnArr.first!.isSelected)
            self.btnArr.first!.isSelected = !self.btnArr.first!.isSelected
        }
    }
    
    /// 处理  收藏按钮 的选中与否-通知处理
    @objc func changeLikeOrNotBySelectedItems() {
        if let vw = (self.superview as? MainVCTabVw) {
            let num = vw.vm?.calculateLikeCountInSelectedItems()
            if num?.s == num?.sAndl {
                self.btnArr.first!.isSelected = true
            }else{
                self.btnArr.first!.isSelected = false
            }
        }
    }
}
