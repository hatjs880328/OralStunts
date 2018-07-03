//
//  CloudMineTavVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import UIKit

class CloudMineTabVw: UIView,UITableViewDelegate,UITableViewDataSource {
    
    var fatherVw: UIView!
    
    var infoTab: UITableView!
    
    var tabVM: CloudMineTabVM!
    
    let headerVwHeight: CGFloat = 10 * APPDelStatic.sizeScale
    
    init(frame: CGRect,fatherVw: UIView) {
        super.init(frame: frame)
        self.fatherVw = fatherVw
        createVw()
        createDel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        // self
        self.fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        // tab
        self.infoTab = UITableView()
        self.infoTab.isScrollEnabled = false
        self.infoTab.backgroundColor = APPDelStatic.lightGray
        self.infoTab.separatorStyle = .none
        self.addSubview(infoTab)
        infoTab.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    func createDel() {
        self.infoTab.delegate = self
        self.infoTab.dataSource = self
        self.tabVM = CloudMineTabVM()
        self.tabVM.userInfoChangeAction = { [weak self]() in
            self?.infoTab.reloadData()
        }
    }
}


// MARK: - tableview - delegate
extension CloudMineTabVw {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tabVM.getCellRows(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tabVM.getSectionNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tabVM.getCell(with: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let con = self.tabVM.didSelectVC(with: indexPath)
        if con == nil { return }
        self.viewController()?.navigationController?.pushViewController(con!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tabVM.rowsHeight(with: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerVwHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerVw = UIView()
        headerVw.frame = CGRect(x: 0, y: 0, width: APPDelStatic.aWeight, height: headerVwHeight)
        headerVw.backgroundColor = APPDelStatic.lightGray
        return headerVw
    }
}
