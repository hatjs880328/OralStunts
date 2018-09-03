//
//  FolderTabVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/23.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class FolderTabVw: UIView,UITableViewDelegate,UITableViewDataSource {
    
    var tab:UITableView!
    
    let folderReuseID:String = "folderReuseID"
    
    var vm: FolderTabVM!
    
    var haveCheckBox = false
    
    var cellDidSelect: ((_ model: FolderCellVModel)->Void)!
    
    init(frame: CGRect,fatherVw:UIView,topVw: UIView?,haveCheckBox: Bool = false) {
        super.init(frame: frame)
        self.haveCheckBox = haveCheckBox
        fatherVw.addSubview(self)
        if topVw == nil {
            self.snp.makeConstraints { (make) in
                make.top.equalTo(5 * APPDelStatic.sizeScale)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.bottom.equalTo(0)
            }
        }else{
            self.snp.makeConstraints { (make) in
                make.top.equalTo(topVw!.snp.bottom).offset(5 * APPDelStatic.sizeScale)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.bottom.equalTo(0)
            }
        }
        
        createVw()
        createVM()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVM() {
        self.vm = FolderTabVM()
        self.vm.reloadAction = { [weak self] () in
            self?.tab.reloadData()
        }
    }
    
    func getData() {
        self.vm.getData()
        self.tab.reloadData()
    }
    
    func createVw() {
        self.tab = UITableView()
        tab.separatorStyle = .none
        self.addSubview(tab)
        tab.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        tab.delegate = self
        tab.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FolderTabCell(style: UITableViewCellStyle.default, reuseIdentifier: folderReuseID,fatherView:self,index: indexPath)
        let cellModel = self.vm.getModel(with: indexPath)
        if self.haveCheckBox {
            cell.setCheckBoxShow()
        }
        cell.setData(with: cellModel)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.vm.getModel(with: indexPath)
        if self.cellDidSelect == nil { return }
        self.cellDidSelect(model)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.cellInfos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75 * APPDelStatic.sizeScale
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "移除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            OTAlertVw().alertShowConfirm(title: "提醒", message: "此操作会将文件夹下的所有便签删除，确定继续吗？", confirmStr: "删除") { [weak self]() in
                self?.vm.deleateOneFolder(with: indexPath)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
}

class FolderTabCell: UITableViewCell {
    
    let title = UILabel()
    
    let time = UILabel()
    
    let count = UILabel()
    
    let checkImage = UIButton()
    
    var folderNoteModel: OTFolderModel!
    
    var selectPush = PublishSubject<(noteid:String,isAdd: Bool,index:IndexPath)>()
    
    var fatherView: UIView!
    
    var index: IndexPath!
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,fatherView: UIView,index:IndexPath) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.index = index
        self.fatherView = fatherView
        createVw()
        initRx()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        let img = UIImageView()
        self.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.top.equalTo(15 * APPDelStatic.sizeScale)
            make.width.equalTo(20)
            make.height.equalTo(20 * APPDelStatic.sizeScale)
        }
        img.image = UIImage(named: "FolderCell.png")
        // title
        self.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10 * APPDelStatic.sizeScale)
            make.centerY.equalTo(img.snp.centerY)
            make.right.equalTo(-18)
            make.height.equalTo(15 * APPDelStatic.sizeScale)
        }
        title.font = APPDelStatic.uiFont(with: 14)
        // check box
        self.addSubview(checkImage)
        //checkImage.backgroundColor = APPDelStatic.lightGray
        checkImage.alpha = 0
        checkImage.snp.makeConstraints { (make) in
            make.right.equalTo(-18)
            make.width.equalTo(25 * APPDelStatic.sizeScale)
            make.height.equalTo(25 * APPDelStatic.sizeScale)
            make.centerY.equalTo(img.snp.centerY)
        }
        checkImage.layer.cornerRadius = 25 * APPDelStatic.sizeScale / 2
        checkImage.setImage(UIImage(named: "circleUnselected.png"), for: UIControlState.normal)
        checkImage.setImage(UIImage(named: "selected.png"), for: UIControlState.selected)
        checkImage.tapActionsGesture {[weak self] () in
            self?.checkAction()
        }
        // modifyTime
        self.addSubview(time)
        time.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.top.equalTo(title.snp.bottom).offset(15 * APPDelStatic.sizeScale)
            make.right.equalTo(-18)
            make.height.equalTo(13 * APPDelStatic.sizeScale)
        }
        time.font = APPDelStatic.uiFont(with: 11)
        time.textColor = UIColor.gray
        // count
        self.addSubview(count)
        count.snp.makeConstraints { (make) in
            make.width.equalTo(250)
            make.top.equalTo(title.snp.bottom).offset(15 * APPDelStatic.sizeScale)
            make.right.equalTo(-18)
            make.height.equalTo(13 * APPDelStatic.sizeScale)
        }
        count.font = APPDelStatic.uiFont(with: 11)
        count.textColor = UIColor.gray
        count.textAlignment = .right
        count.alpha = 0
        // bot line
        let line = UIView()
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.height.equalTo(0.5)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        line.backgroundColor = APPDelStatic.lightGray
    }
    
    func initRx() {
        let _ = self.selectPush.bind(to: (self.fatherView as! FolderTabVw).vm.selectCellInput)
        
        let _ = (self.fatherView as! FolderTabVw).vm.selectCelloutput.subscribe { [weak self](index) in
            if index.element == nil { return }
            self?.changeView(index.element!.index,index.element!.isAdd)
        }
    }
    
    func setData(with model: FolderCellVModel) {
        self.folderNoteModel = model.sourceNote
        self.title.text = model.title
        self.time.text = model.createTime
        self.count.text = model.count
    }
    
    /// 外部调用，显示出选择框，默认不显示
    func setCheckBoxShow() {
        self.checkImage.alpha = 1
    }
    
    /// 发送信号
    func checkAction() {
        if !checkImage.isSelected {
            self.selectPush.onNext((noteid: self.folderNoteModel.id, isAdd: true,index:self.index))
        }else{
            self.selectPush.onNext((noteid: self.folderNoteModel.id, isAdd: false,index:self.index))
        }
    }
    
    /// 接受信号并处理view
    func changeView(_ index:IndexPath,_ isAdd:Bool) {
        if index == self.index {
            if isAdd {
                checkImage.backgroundColor = UIColor.white
                checkImage.isSelected = true
            }else{
                checkImage.isSelected = false
            }
        }else{
            if isAdd {
                checkImage.isSelected = false
            }else{
                checkImage.isSelected = false
            }
        }
    }
}
