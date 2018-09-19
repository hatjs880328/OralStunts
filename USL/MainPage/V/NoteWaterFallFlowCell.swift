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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        createVw()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.addSubview(titleLb)
        self.addSubview(createTimeLb)
        self.addSubview(contentRealTxtLb)
        //title
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.equalTo(5)
            make.height.equalTo(15)
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
        createTimeLb.font = APPDelStatic.uiFont(with: 11)
        createTimeLb.textColor = UIColor.gray
        //contentLb
        contentRealTxtLb.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.equalTo(createTimeLb.snp.bottom).offset(8)
            make.height.equalTo(13)
            make.right.equalTo(-5)
        }
        contentRealTxtLb.font = APPDelStatic.uiFont(with: 11)
        contentRealTxtLb.textColor = UIColor.gray
        contentRealTxtLb.text = "内容:"
        //config
        self.layer.borderColor = APPDelStatic.lineGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }
    
    func setData(note: SearchvcVmodel) {
        self.titleLb.text = note.title
        self.createTimeLb.text = note.modifyTime
        for eachItem in 0 ..< note.sourceModel.contentTxt.count {
            let contentTxtLb = UILabel()
            self.addSubview(contentTxtLb)
            contentTxtLb.snp.makeConstraints { (make) in
                make.left.equalTo(5)
                make.top.equalTo(contentRealTxtLb.snp.bottom).offset(8 + 18 * eachItem)
                make.height.equalTo(13)
                make.right.equalTo(-5)
            }
            contentTxtLb.font = APPDelStatic.uiFont(with: 11)
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
}
