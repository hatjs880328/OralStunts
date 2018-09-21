//
//  SearchVCTabVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/21.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation



class SearchVCTabVM: NSObject {
    
    var dataSource: [SearchvcVmodel] = [] {
        didSet {
            reloadTabAndWaterFall()
        }
    }
    
    /// left数据源变更UI
    var reloadAction: (()->Void)!
    
    /// right数据变更UI
    var addNewDataAction: (()->Void)?
    
    var cellHeight:CGFloat = 70 * APPDelStatic.sizeScale
    
    /// 是否全选
    var isSelectAll: Bool = false {
        didSet {
            if self.reloadAction == nil { return }
            self.reloadAction()
        }
    }
    
    override init() {
        super.init()
    }
    
    func deleateOne(with index:IndexPath) {
        var result = [SearchvcVmodel]()
        for i in 0 ..< dataSource.count {
            if index.row != i {
                result.append(dataSource[i])
                continue
            }
        }
        self.dataSource = result
    }
    
    /// 分页获取数据
    func loadData(page: Int,orderby: String,sort:String) {
        self.dataSource = loopProgressModel2VModel(NoteLogicBLL().getNoteInfo(page: page, order: orderby, sortType: sort))
    }
    
    /// 获取没有分配文件夹的数据
    func loadNonFolderData() {
        self.dataSource = loopProgressModel2VModel(NoteLogicBLL().getNonFolderData())
    }
    
    /// 获取文件夹下面数据
    func loadData(with folderID: String) {
        self.dataSource = loopProgressModel2VModel(NoteLogicBLL().loadData(with: folderID))
    }
    
    /// 获取所有收藏的数据
    func loadFavData() {
        self.dataSource = loopProgressModel2VModel(NoteLogicBLL().getFavData())
    }
    
    /// 根据查询条件获取数据
    func requestDataByWhereSql(sql: String) {
        self.dataSource = loopProgressModel2VModel(NoteLogicBLL().getNoteByWhereSQL(sqlStr: sql))
    }
    
    func getData(with index:IndexPath)->SearchvcVmodel {
        let model = self.dataSource[index.row]
        return model
    }
    
    /// 批量转换
    func loopProgressModel2VModel(_ models: [OTNoteModel])->[SearchvcVmodel] {
        var result = [SearchvcVmodel]()
        for eachItem in models {
            let model = SearchvcVmodel()
            model.setData(model: eachItem)
            result.append(model)
        }
        return result
    }
    
    /// 移动之前处理方法-将bll中展示model赋值
    func moveNoteProgressShowModel(index: IndexPath) {
        NoteCreatingBLL.getInstance().showingNoteModel = self.dataSource[index.row].sourceModel
    }
    
    /// 点击事件处理
    func didSelectActionReturnVC(indexPath:IndexPath)->IIBaseViewController {
        let model = self.getData(with: indexPath)
        let con = NoteTimeLineViewController()
        NoteCreatingBLL.getInstance().showingNoteModel = model.sourceModel
        con.hidesBottomBarWhenPushed = true
        con.presentedVcHasNavigation = true
        return con
    }
    
    /// 点击单个项目跳转到timeline页面
    func didSelectedOneItemAction(indexPath: IndexPath)->UIViewController? {
        if longpressIsActive() {
            self.selectOneItem(with: indexPath)
            return nil
        }
        let con = NoteTimeLineViewController()
        self.moveNoteProgressShowModel(index: indexPath)
        con.hidesBottomBarWhenPushed = true
        return con
    }
    
    /// 选中某一个item[这一个选中其他的都取消选中 & 刷新瀑布流]
    func selectOneItem(with indexpath: IndexPath) {
        for eachItem in 0 ..< self.dataSource.count {
            if indexpath.row == eachItem {
                self.dataSource[eachItem].isSelected = true
            }else{
                //self.dataSource[eachItem].isSelected = false
            }
        }
        reloadTabAndWaterFall()
    }
    
    /// 选中所有的ITEM[刷新tableview][true: 全选，false:全部取消]
    func selectAllItems(selectOrDeselect:Bool) {
        for eachItem in 0 ..< self.dataSource.count {
            self.dataSource[eachItem].isSelected = selectOrDeselect
        }
        reloadTabAndWaterFall()
    }
    
    /// 判定是否激活了长按选中
    func longpressIsActive()->Bool {
        var flag = false
        for eachItem in self.dataSource {
            if eachItem.isSelected {
                flag = true
                break
            }
        }
        return flag
    }
    
    /// 根据选中的标识，删除items并刷新tab
    func deleteNotesBySelectedFlag() {
        var index = self.dataSource.count - 1
        while index >= 0 {
            if self.dataSource[index].isSelected {
                NoteLogicBLL().deleateOneNote(with: self.dataSource[index].noteID)
                self.dataSource.remove(at: index)
            }
            index -= 1
        }
        self.reloadTabAndWaterFall()
    }
    
    /// 根据选中的标识，移动item并刷新tab[返回自动刷新]
    func moveNoteBySelectedFlag()->UIViewController{
        var ids: [String] = []
        for item in self.dataSource {
            if item.isSelected {
                ids.append(item.noteID)
            }
        }
        let con = MoveNote2FolderViewController()
        con.hidesBottomBarWhenPushed = true
        con.shouldMoveID = ids
        
        return con
    }
    
    /// 刷新tableview & waterfall
    func reloadTabAndWaterFall() {
        if self.reloadAction == nil { return }
        self.reloadAction()
        if self.addNewDataAction == nil { return }
        self.addNewDataAction!()
    }
    
    /// 全选与取消
    func selectAllOrNot()->String {
        if self.isSelectAll  {
            self.isSelectAll = false
            return "全选"
        }else{
            self.isSelectAll = true
            return "取消全选"
        }
    }
    
}
