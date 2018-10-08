//
//  NoteTimerLineVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/24.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class NoteTimerLineVw: UIView, UITableViewDataSource, UITableViewDelegate {

    let tab: UITableView = UITableView()

    let reuseID = "NotetimelineReuseid"

    let vm = NoteTimeLineVM()

    init(frame: CGRect, fatherVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10 * APPDelStatic.sizeScale, left: 18, bottom: 0, right: 3))
        }
        initVw()
        initVM()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initVw() {
        self.addSubview(tab)
        tab.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        tab.delegate = self
        tab.dataSource = self
        tab.separatorStyle = .none
    }

    func initVM() {
        self.vm.reloadAction = {[weak self]() in
            self?.tab.reloadData()
        }
        self.vm.getData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseID) as? NoteTimeLineCell
        if cell == nil {
            cell = NoteTimeLineCell(style: UITableViewCellStyle.default, reuseIdentifier: reuseID, index: indexPath)
        }
        let model = self.vm.getModel(with: indexPath)
        cell?.setData(model: model)
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.cellInfo.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.vm.getModel(with: indexPath).cellHeight
        return height
    }
}

class NoteTimeLineCell: UITableViewCell {

    let createTime = UILabel()

    let picVw: UIView = UIView()

    let txtLb: UILabel = UILabel()

    let vedioImg = UIImageView()

    var volumeVw: OTVolumeVw!

    var vm = TimeLineTabCellVM()

    var index: IndexPath!

    init(style: UITableViewCellStyle, reuseIdentifier: String?, index: IndexPath) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.index = index
        initVw()
        createVm()
    }

    /// create vm
    func createVm() {
        self.vm.setAction { [weak self]() in
            self?.vedioImg.image = UIImage(named: "noPlay.png")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 60 + height
    func initVw() {
        let line = UIView()
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(3)
            make.width.equalTo(1)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        line.backgroundColor = APPDelStatic.themeColor
        // time
        self.addSubview(createTime)
        createTime.snp.makeConstraints { (make) in
            make.left.equalTo(15 * APPDelStatic.sizeScale)
            make.right.equalTo(0)
            make.top.equalTo(5 * APPDelStatic.sizeScale)
            make.height.equalTo(14 * APPDelStatic.sizeScale)
        }
        createTime.font = APPDelStatic.uiFont(with: 12)
        createTime.textColor = UIColor.gray
        // circle vw
        let circleLine = UIView()
        self.addSubview(circleLine)
        circleLine.snp.makeConstraints { (make) in
            make.left.equalTo(0.5)
            make.width.equalTo(6)
            make.top.equalTo(8 * APPDelStatic.sizeScale)
            make.height.equalTo(6)
        }
        circleLine.backgroundColor = APPDelStatic.themeColor
        circleLine.layer.cornerRadius = 3
        // pic
        self.addSubview(vedioImg)
        vedioImg.snp.makeConstraints { (make) in
            make.left.equalTo(createTime.snp.left)
            make.width.equalTo(35 * APPDelStatic.sizeScale)
            make.top.equalTo(createTime.snp.bottom).offset(10 * APPDelStatic.sizeScale)
            make.height.equalTo(35 * APPDelStatic.sizeScale)
        }
        vedioImg.image = UIImage(named: "noPlay.png")
        vedioImg.tapActionsGesture {[weak self]() in
            //播放音频
            if self == nil { return }
            self?.vm.playVedio(with: self!.index)
            //更改UI
            self?.vedioImg.image = UIImage(named: "vedioPlay.png")
        }
        // volumeVw
        volumeVw = OTVolumeVw(frame: CGRect.zero, fatherVw: self)
        self.addSubview(volumeVw)
        volumeVw.snp.remakeConstraints { (make) in
            make.left.equalTo(vedioImg.snp.right).offset(3 * APPDelStatic.sizeScale)
            make.right.equalTo(0)
            make.centerY.equalTo(vedioImg.snp.centerY)
            make.height.equalTo(25 * APPDelStatic.sizeScale)
        }
        // txt lab
        self.addSubview(txtLb)
        txtLb.numberOfLines = 0
        txtLb.layer.cornerRadius = 3
        txtLb.layer.borderColor = APPDelStatic.lightGray.cgColor
        txtLb.layer.borderWidth = 0.5
        txtLb.snp.makeConstraints { (make) in
            make.left.equalTo(createTime.snp.left)
            make.right.equalTo(0)
            make.top.equalTo(vedioImg.snp.bottom).offset(10 * APPDelStatic.sizeScale)
            make.bottom.equalTo(-15 * APPDelStatic.sizeScale)
        }
        txtLb.font = APPDelStatic.uiFont(with: 11)
    }

    func setData(model: NoteTimelineVModel) {
        self.txtLb.text = model.txt
        self.createTime.text = model.createTime
        for eachItem in model.contentVolumeArr {
            self.volumeVw.setValue(value: eachItem)
        }
    }
}
