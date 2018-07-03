//
//  MianVCTabCreateVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/28.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class MianVCTabCreateVw: UIView,UITableViewDelegate,UITableViewDataSource {
    var tab: UITableView = UITableView()
    let reuseID = "MianVCTabCreateVwReuseID"
    var vm = SearchVCTabVM()
    init(frame: CGRect,fatherVw: UIView,topVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(topVw.snp.bottom).offset(10 * APPDelStatic.sizeScale)
            make.bottom.equalTo(0)
        }
        initVw()
        initVm()
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
    
    func initVm() {
        self.vm.reloadAction = {[weak self]() in
            self?.tab.reloadData()
        }
        self.vm.loadNonFolderData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseID) as? SearchVCTabCell
        if cell == nil {
            cell = SearchVCTabCell(style: UITableViewCellStyle.default, reuseIdentifier: reuseID)
        }
        let model = self.vm.getData(with: indexPath)
        cell!.setData(model: model)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.vm.getData(with: indexPath)
        let con = NoteTimeLineViewController()
        NoteCreatingBLL.getInstance().showingNoteModel = model.sourceModel
        con.hidesBottomBarWhenPushed = true
        self.viewController()?.navigationController?.pushViewController(con, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.vm.cellHeight
    }
}
