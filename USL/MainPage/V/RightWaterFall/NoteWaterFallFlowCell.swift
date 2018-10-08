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

    var likeOrNotBtn = UIButton()

    var createTimeLb: UILabel = UILabel()

    var contentRealTxtLb: UILabel = UILabel()

    var subTitleLb: [UILabel] = []

    // note id
    var realNoteId: String = ""

    var longpressAction:(() -> Void)!

    var index: IndexPath?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        createVw()
        addLongPressGes()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 5 16 8 13 8 13 8 18 * each
    func createVw() {
        self.addSubview(titleLb)
        self.addSubview(likeOrNotBtn)
        self.addSubview(createTimeLb)
        self.addSubview(contentRealTxtLb)
        //like or note
        likeOrNotBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-2)
            make.top.equalTo(5)
            make.height.equalTo(15)
            make.width.equalTo(15)
        }
        likeOrNotBtn.setImage(UIImage(named: "unlike"), for: UIControlState.normal)
        likeOrNotBtn.setImage(UIImage(named: "notelike"), for: UIControlState.selected)
        //title
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.equalTo(5)
            make.height.equalTo(16)
            make.right.equalTo(likeOrNotBtn.snp.left).offset(-2)
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
        //config
        self.layer.borderColor = APPDelStatic.lineGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }

    func setData(note: SearchvcVmodel, indexPath: IndexPath) {
        self.index = indexPath
        self.titleLb.text = note.title
        self.createTimeLb.text = note.modifyTime
        self.realNoteId = note.noteID
        self.likeOrNotBtn.isSelected = note.isLike
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
        if note.isSelected {
            self.borderColor = APPDelStatic.themeColor
        } else {
            self.borderColor = APPDelStatic.lineGray
        }
    }

    func addLongPressGes() {
        let long = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(sender:)))
        long.minimumPressDuration = 0.6
        self.addGestureRecognizer(long)
    }

    func removeSubTitle() {
        self.layer.borderColor = APPDelStatic.lineGray.cgColor
        for eachItem in self.subTitleLb {
            eachItem.removeFromSuperview()
        }
        self.subTitleLb.removeAll()
    }

    @objc func longPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            if self.longpressAction == nil { return }
            self.longpressAction!()
            AudioServicesPlaySystemSound(1_520)
        }
    }
}
