//
//  SettingViewController.swift
//  OralStunts
//  设置页面
//  Created by Noah_Shan on 2018/6/5.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class SettingViewController: IIBaseViewController,UITableViewDelegate,UITableViewDataSource {

    let dataSource = [("关闭帮助提示","setting.png")]
    
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
        let cell = SettingCell(style: UITableViewCellStyle.default, reuseIdentifier: reuseID)
        let cellModel = self.dataSource[indexPath.row]
        cell.setData(tupleInfo: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51 * APPDelStatic.sizeScale
    }
}


class SettingCell: UITableViewCell {
    
    let closeSwit = UISwitch()
    
    let titleLb = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.centerY.equalTo(self.snp.centerY)
            make.bottom.equalTo(-10 * APPDelStatic.sizeScale)
            make.width.equalTo(100 * APPDelStatic.sizeScale)
        }
        titleLb.font = APPDelStatic.uiFont(with: 13)
        //开关
        self.addSubview(closeSwit)
        closeSwit.snp.makeConstraints { (make) in
            make.right.equalTo(-18)
            make.top.equalTo(10 * APPDelStatic.sizeScale)
            make.bottom.equalTo(10 * APPDelStatic.sizeScale)
            make.width.equalTo(51 * APPDelStatic.sizeScale)
        }
        closeSwit.setOn(true, animated: false)
        closeSwit.onTintColor = APPDelStatic.themeColor
        closeSwit.addTarget(self, action: #selector(self.setOn), for: UIControlEvents.touchUpInside)
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
    
    func setData(tupleInfo:(String,String)) {
        self.titleLb.text = tupleInfo.0
        let onOrOff = MineBLL().getUserInfo().alertHelpInfo == "true" ? true : false
        self.closeSwit.setOn(onOrOff, animated: false)
    }
    
    @objc func setOn() {
        if self.closeSwit.isOn {
            MineBLL().updateAlertInfo(alert: true)
        }else{
            MineBLL().updateAlertInfo(alert: false)
        }
    }
}
