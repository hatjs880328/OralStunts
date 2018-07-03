//
//  MinePersionalTabVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/24.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


class MinePersionalTabVw: UIView,UITableViewDelegate,UITableViewDataSource {
    
    var tab = UITableView()
    
    let minePersonalTabCellReuseid = "minePersonalTabCellReuseid"
    
    let vm = MinePersonalTabVM()
    
    init(frame: CGRect,fatherVw: UIView,topVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(topVw.snp.bottom).offset(15 * APPDelStatic.sizeScale)
            make.bottom.equalTo(0)
        }
        createVw()
    }
    
    func createVm() {
        self.vm.reloadAction = { [weak self]() in
            self?.tab.reloadData()
        }
    }
    
    func createVw() {
        self.addSubview(tab)
        tab.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        tab.separatorStyle = .none
        tab.delegate = self
        tab.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.cellInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MinePersonTabCell(style: UITableViewCellStyle.default, reuseIdentifier: minePersonalTabCellReuseid)
        let models = self.vm.getInfo(with: indexPath)
        cell.setData(tuple: models)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65 * APPDelStatic.sizeScale
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let con = self.vm.jump(index: indexPath)
        self.viewController()?.navigationController?.pushViewController(con, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MinePersonTabCell: UITableViewCell {
    var title:UILabel = UILabel()
    var img = UIImageView()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        let bgvw = UIView()
        self.addSubview(bgvw)
        bgvw.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(5, 0, 5, 0))
        }
        bgvw.layer.cornerRadius = 3
        bgvw.layer.borderColor = UIColor.gray.cgColor
        bgvw.layer.borderWidth = 0.5
        // img
        self.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.left.equalTo(10 * APPDelStatic.sizeScale)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(20 * APPDelStatic.sizeScale)
            make.height.equalTo(20 * APPDelStatic.sizeScale)
        }
        // title
        self.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(25 * APPDelStatic.sizeScale)
            make.width.equalTo(200 * APPDelStatic.sizeScale)
            make.height.equalTo(25 * APPDelStatic.sizeScale)
            make.centerY.equalTo(img.snp.centerY)
        }
        title.font = APPDelStatic.uiFont(with: 13)
    }
    
    func setData(tuple:(String,String)) {
        self.title.text = tuple.0
        self.img.image = UIImage(named: tuple.1)
    }
}
