//
//  SettingViewController.swift
//  OralStunts
//  设置页面
//  Created by Noah_Shan on 2018/6/5.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class SettingViewController: IIBaseViewController,UITableViewDelegate,UITableViewDataSource {

    let dataSource = [("关闭帮助提示",UIImage(named: "helpswitch")),("清除所有缓存",UIImage(named: "removedisk"))]
    
    let reuseID = "SETTINGVCCELLREUSEID"
    
    var tab: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createVw()
    }
    
    func createVw() {
        if self.tab != nil { return }
        self.tab = UITableView()
        self.view.addSubview(tab)
        tab.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        tab.delegate = self
        tab.dataSource = self
        tab.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showSwt = indexPath.row == 0 ? true : false
        let cell = SettingCell(style: UITableViewCellStyle.default, reuseIdentifier: reuseID,showSwt:showSwt)
        let cellModel = self.dataSource[indexPath.row]
        cell.setData(tupleInfo: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51 * APPDelStatic.sizeScale
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            //清除缓存
            OTAlertVw().alertShowConfirm(title: "提示", message: "确定要删除所有缓存信息吗？",confirmStr: "删除") {
                NoteLogicBLL().deleteAllInfo()
                FolderBLL().deleteAllInfo()
            }
        }
    }
    
    
}


class SettingCell: UITableViewCell {
    
    let closeSwit = UISwitch()
    
    let titleLb = UILabel()
    
    var showSwt: Bool = true
    
    var headImg = UIImageView()
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,showSwt:Bool = true) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.showSwt = showSwt
        self.selectionStyle = .none
        createVw()
        if !showSwt {
            self.accessoryType = .disclosureIndicator
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.addSubview(headImg)
        self.addSubview(titleLb)
        headImg.snp.makeConstraints { (mk) in
            mk.left.equalTo(18)
            mk.centerY.equalTo(self.snp.centerY)
            mk.width.equalTo(20)
            mk.height.equalTo(20)
        }
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(headImg.snp.right).offset(10)
            make.centerY.equalTo(self.snp.centerY)
            make.bottom.equalTo(-10 * APPDelStatic.sizeScale)
            make.width.equalTo(100 * APPDelStatic.sizeScale)
        }
        titleLb.font = APPDelStatic.uiFont(with: 13)
        //开关
        self.addSubview(closeSwit)
        closeSwit.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.top.equalTo(10 * APPDelStatic.sizeScale)
            make.bottom.equalTo(10 * APPDelStatic.sizeScale)
            make.width.equalTo(51 * APPDelStatic.sizeScale)
        }
        closeSwit.setOn(true, animated: false)
        closeSwit.onTintColor = APPDelStatic.themeColor
        closeSwit.addTarget(self, action: #selector(self.setOn), for: UIControlEvents.touchUpInside)
        if showSwt {
            closeSwit.alpha = 1
        }else{
            closeSwit.alpha = 0
        }
        // bot line
        let line = UIView()
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.height.equalTo(0.5)
            make.bottom.equalTo(-1)
            make.right.equalTo(0)
        }
        line.backgroundColor = UIColor.gray
    }
    
    func setData(tupleInfo:(String,UIImage?)) {
        self.titleLb.text = tupleInfo.0
        let onOrOff = MineBLL().getUserInfo().alertHelpInfo == "true" ? true : false
        self.closeSwit.setOn(onOrOff, animated: false)
        self.headImg.image = tupleInfo.1
    }
    
    @objc func setOn() {
        if self.closeSwit.isOn {
            MineBLL().updateAlertInfo(alert: true)
        }else{
            MineBLL().updateAlertInfo(alert: false)
        }
    }
}
