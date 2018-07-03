//
//  LstaedEditedInfoVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/25.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

/// 最近一次编辑的内容view-音频 + 时间
class LstaedEditedInfoVw: UIView {
    
    var vedioVw: OTVolumeVw!
    
    var timeLB: UILabel = UILabel()
    
    init(frame: CGRect,fatherVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        initVw()
        setData()
    }
    
    func initVw() {
        self.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(5 * APPDelStatic.sizeScale)
            make.height.equalTo(45 * APPDelStatic.sizeScale)
        }
        //播放按钮
        let playImg = UIImageView()
        self.addSubview(playImg)
        playImg.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(20 * APPDelStatic.sizeScale)
            make.top.equalTo(5)
            make.height.equalTo(20 * APPDelStatic.sizeScale)
        }
        playImg.image = UIImage(named: "vedioPlay.png")
        //音频码
        vedioVw = OTVolumeVw(frame: CGRect.zero, fatherVw: self)
        vedioVw.snp.remakeConstraints { (make) in
            make.left.equalTo(playImg.snp.right).offset(3 * APPDelStatic.sizeScale)
            make.right.equalTo(0)
            make.centerY.equalTo(playImg.snp.centerY)
            make.height.equalTo(25 * APPDelStatic.sizeScale)
        }
        // modifyTime
        self.addSubview(timeLB)
        timeLB.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(playImg.snp.bottom).offset(8 * APPDelStatic.sizeScale)
            make.height.equalTo(11 * APPDelStatic.sizeScale)
        }
        timeLB.font = APPDelStatic.uiFont(with: 11)
        timeLB.textColor = UIColor.gray
    }
    
    func setData() {
        let realModel = NoteCreatingBLL.getInstance().showingNoteModel
        let model = NoteTimelineVModel(model: realModel, txt: realModel.contentTxt.last!, modifyTime: realModel.modifyTime.last!,contentVolumeArr: realModel.videoNumberArr.last!)
        self.timeLB.text = "最近" + model.createTime
        for eachItem in model.contentVolumeArr {
            self.vedioVw.setValue(value: eachItem)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("LstaedEditedInfoVw init fail..")
    }
}
