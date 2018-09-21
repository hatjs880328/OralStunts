//
//  SearchVCTabVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/21.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class SearchVCTabVw: UIView,UITableViewDelegate,UITableViewDataSource {
    
    let tabVw: UITableView = UITableView()
    
    var vm: SearchVCTabVM!
    
    let resueID:String = "searchVCTabReid"
    
    init(frame: CGRect,fatherVw:UIView,topVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.snp.makeConstraints { ( make ) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(topVw.snp.bottom).offset(10 * APPDelStatic.sizeScale)
            make.bottom.equalTo(0)
        }
        tabVw.separatorStyle = .none
        createVw()
        createVM()
    }
    
    func createVw() {
        self.addSubview(tabVw)
        tabVw.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        tabVw.delegate = self
        tabVw.dataSource = self
    }
    
    func createVM() {
        self.vm = SearchVCTabVM()
        self.vm.reloadAction = { [weak self] () in
            self?.tabVw.progressNodataAndLoadingBeforeReloaddata()
            self?.tabVw.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: resueID) as? SearchVCTabCell
        if cell == nil {
            cell = SearchVCTabCell(style: UITableViewCellStyle.default, reuseIdentifier: resueID)
        }
        let model = self.vm.getData(with: indexPath)
        cell?.setData(model: model,isSelectAll: self.vm.isSelectAll)
        cell?.refreshAction = {
            if let folderVc = self.viewController() as? FolderContentsViewController {
                folderVc.getData()
            }
            if let searchVc = self.viewController() as? SearchViewController {
                searchVc.searchVw.searFd.text! = searchVc.searchVw.searFd.text!
            }
            if let favVc = self.viewController() as? MineFavViewController {
                favVc.getData()
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.vm.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let con = self.vm.didSelectActionReturnVC(indexPath: indexPath)
        // 文件夹详情中跳转到单个note页面，文件夹详情是有导航栏
        con.presentedVcHasNavigation = true
        self.viewController()?.navigationController?.pushViewController(con, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let moveAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "移动") { (action, index) in
            self.vm.moveNoteProgressShowModel(index: indexPath)
            let con = MoveNote2FolderViewController()
            con.shouldMoveID = [NoteCreatingBLL.getInstance().showingNoteModel.id]
            con.presentedVcHasNavigation = true
            self.viewController()!.navigationController?.pushViewController(con, animated: true)
        }
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "删除") { (action, index) in
            let model = self.vm.getData(with: indexPath)
            NoteLogicBLL().deleateOneNote(with: model.noteID)
            self.vm.deleateOne(with: indexPath)
            tableView.reloadData()
        }
        
        return [deleteAction,moveAction]
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
