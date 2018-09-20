//
//  NoteWaterFallFlowCell.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/19.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation


class NoteWaterFallFlowCell: UICollectionViewCell {
    
    var titleLb: UILabel = UILabel()
    
    var createTimeLb: UILabel = UILabel()
    
    var contentRealTxtLb: UILabel = UILabel()
    
    var subTitleLb: [UILabel] = []
    
    var isLikeBtn: UIButton = UIButton()
    
    var moveBtn: UIButton = UIButton()
    
    var deleteBtn: UIButton = UIButton()
    
    // note id
    var realNoteId:String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        createVw()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 5 16 8 13 8 13 8 18 * each
    func createVw() {
        self.addSubview(titleLb)
        self.addSubview(createTimeLb)
        self.addSubview(contentRealTxtLb)
        self.addSubview(isLikeBtn)
        self.addSubview(moveBtn)
        self.addSubview(deleteBtn)
        //title
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.equalTo(5)
            make.height.equalTo(16)
            make.right.equalTo(-5)
        }
        titleLb.font = APPDelStatic.uiFont(with: 13)
        titleLb.textColor = UIColor.black
        //time
        createTimeLb.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.equalTo(titleLb.snp.bottom).offset(8)
            make.height.equalTo(13)
            make.right.equalTo(-5)
        }
        createTimeLb.font = APPDelStatic.uiFont(with: 10)
        createTimeLb.textColor = UIColor.gray
        //contentLb
        contentRealTxtLb.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.equalTo(createTimeLb.snp.bottom).offset(8)
            make.height.equalTo(13)
            make.right.equalTo(-5)
        }
        contentRealTxtLb.font = APPDelStatic.uiFont(with: 10)
        contentRealTxtLb.textColor = UIColor.gray
        contentRealTxtLb.text = "内容:"
//        //like
//        self.isLikeBtn.snp.makeConstraints { (make) in
//            make.left.equalTo(10)
//            make.bottom.equalTo(-5)
//            make.height.equalTo(25)
//            make.width.equalTo(25)
//        }
//        self.isLikeBtn.setImage(UIImage(named: "unlike"), for: UIControlState.normal)
//        self.isLikeBtn.setImage(UIImage(named: "notelike"), for: UIControlState.selected)
//        self.isLikeBtn.tapActionsGesture {[weak self] () in
//            self?.isLikeFunc()
//        }
//        //move
//        self.moveBtn.snp.makeConstraints { (make) in
//            make.centerX.equalTo(self.snp.centerX)
//            make.bottom.equalTo(-5)
//            make.height.equalTo(25)
//            make.width.equalTo(25)
//        }
//        self.moveBtn.setImage(UIImage(named: "water_fall_move_icon"), for: UIControlState.normal)
//        //delete
//        self.deleteBtn.snp.makeConstraints { (make) in
//            make.right.equalTo(-10)
//            make.bottom.equalTo(-5)
//            make.height.equalTo(25)
//            make.width.equalTo(25)
//        }
//        self.deleteBtn.setImage(UIImage(named: "water_fall_delte_icon"), for: UIControlState.normal)
        //config
        self.layer.borderColor = APPDelStatic.lineGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }
    
    func setData(note: SearchvcVmodel) {
        self.titleLb.text = note.title
        self.createTimeLb.text = note.modifyTime
        self.realNoteId = note.noteID
        self.isLikeBtn.isSelected = note.isLike
        for eachItem in 0 ..< note.sourceModel.contentTxt.count {
            let contentTxtLb = UILabel()
            self.addSubview(contentTxtLb)
            contentTxtLb.snp.makeConstraints { (make) in
                make.left.equalTo(5)
                make.top.equalTo(contentRealTxtLb.snp.bottom).offset(8 + 18 * eachItem)
                make.height.equalTo(13)
                make.right.equalTo(-5)
            }
            contentTxtLb.font = APPDelStatic.uiFont(with: 10)
            contentTxtLb.textColor = UIColor.gray
            contentTxtLb.text = note.sourceModel.contentTxt[eachItem]
            self.subTitleLb.append(contentTxtLb)
        }
    }
    
    func removeSubTitle() {
        for eachItem in self.subTitleLb {
            eachItem.removeFromSuperview()
        }
        self.subTitleLb.removeAll()
    }
    
    @objc func isLikeFunc() {
        NoteCreatingBLL.getInstance().setShowingModel(with: self.realNoteId)
        if self.isLikeBtn.isSelected {
            //取消收藏
            self.isLikeBtn.isSelected = false
            NoteLogicBLL().likeOneModel(isLike: false)
        }else{
            //收藏
            self.isLikeBtn.isSelected = true
            NoteLogicBLL().likeOneModel(isLike: true)
        }
        //self.refreshAction?()
    }
    
    func move() {
        
    }
    
    func delete() {
        
    }
}
