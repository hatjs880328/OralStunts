//
//  SearchVCTabCell.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/21.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class SearchVCTabCell: UITableViewCell {
    
    var titleLB:UILabel = UILabel()
    var abstractLB: UILabel = UILabel()
    var modifyTimeLb:UILabel = UILabel()
    /// 是否喜欢此记录
    var isLike: UIButton = UIButton()
    // refreshAction
    var refreshAction: (()->Void)?
    // note id
    var realNoteId:String = ""
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.addSubview(titleLB)
        self.addSubview(abstractLB)
        self.addSubview(modifyTimeLb)
        self.addSubview(isLike)
        // title
        titleLB.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(10 * APPDelStatic.sizeScale)
            make.height.equalTo(15 * APPDelStatic.sizeScale)
        }
        titleLB.font = APPDelStatic.uiFont(with: 13)
        // abstract lb
        abstractLB.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(titleLB.snp.bottom).offset(5 * APPDelStatic.sizeScale)
            make.height.equalTo(13 * APPDelStatic.sizeScale)
        }
        abstractLB.numberOfLines = 0
        abstractLB.font = APPDelStatic.uiFont(with: 11)
        abstractLB.textColor = UIColor.gray
        // modifytime
        modifyTimeLb.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(abstractLB.snp.bottom).offset(5 * APPDelStatic.sizeScale)
            make.height.equalTo(13 * APPDelStatic.sizeScale)
        }
        modifyTimeLb.font = APPDelStatic.uiFont(with: 11)
        modifyTimeLb.textColor = UIColor.gray
        // isLike
        isLike.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.centerY.equalTo(self.titleLB.snp.centerY)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        isLike.setImage(UIImage(named: "unlike"), for: UIControlState.normal)
        isLike.setImage(UIImage(named: "notelike"), for: UIControlState.selected)
        isLike.tapActionsGesture {[weak self] () in
            self?.isLikeFunc()
        }
        // line
        let botLine = UIView()
        self.addSubview(botLine)
        botLine.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.left.equalTo(18)
            make.bottom.equalTo(self.snp.bottom).offset(-0.5)
            make.height.equalTo(0.5)
        }
        botLine.backgroundColor = APPDelStatic.lineGray
    }
    
    func setData(model: SearchvcVmodel,isSelectAll: Bool = false) {
        self.titleLB.text = model.title
        self.abstractLB.text = model.abstract
        self.modifyTimeLb.text = model.modifyTime
        if isSelectAll {
            self.titleLB.textColor = APPDelStatic.themeColor
        }else {
            self.titleLB.textColor = UIColor.black
        }
        self.isLike.isSelected = model.isLike
        realNoteId = model.noteID
    }
    
    @objc func isLikeFunc() {
        NoteCreatingBLL.getInstance().setShowingModel(with: self.realNoteId)
        if self.isLike.isSelected {
            //取消收藏
            self.isLike.isSelected = false
            NoteLogicBLL().likeOneModel(isLike: false)
        }else{
            //收藏
            self.isLike.isSelected = true
            NoteLogicBLL().likeOneModel(isLike: true)
        }
        self.refreshAction?()
    }
}
