//
//  SearchVCTabVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/21.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation



class SearchVCTabVM: NSObject {
    
    var dataSource: [OTNoteModel] = [] {
        didSet {
            if self.reloadAction == nil { return }
            self.reloadAction()
        }
    }
    
    var reloadAction: (()->Void)!
    
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
        var result = [OTNoteModel]()
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
        self.dataSource = NoteLogicBLL().getNoteInfo(page: page, order: orderby, sortType: sort)
    }
    
    /// 获取没有分配文件夹的数据
    func loadNonFolderData() {
        self.dataSource = NoteLogicBLL().getNonFolderData()
    }
    
    /// 获取文件夹下面数据
    func loadData(with folderID: String) {
        self.dataSource = NoteLogicBLL().loadData(with: folderID)
    }
    
    /// 获取所有收藏的数据
    func loadFavData() {
        self.dataSource = NoteLogicBLL().getFavData()
    }
    
    /// 根据查询条件获取数据
    func requestDataByWhereSql(sql: String) {
        self.dataSource = NoteLogicBLL().getNoteByWhereSQL(sqlStr: sql)
    }
    
    func getData(with index:IndexPath)->SearchvcVmodel {
        let model = self.dataSource[index.row]
        let realmodel = SearchvcVmodel()
        realmodel.setData(model: model)
        return realmodel
    }
    
    /// 移动之前处理方法-将bll中展示model赋值
    func moveNoteProgressShowModel(index: IndexPath) {
        NoteCreatingBLL.getInstance().showingNoteModel = self.dataSource[index.row]
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

class SearchvcVmodel: NSObject {
    
    var title = ""
    var abstract = ""
    var modifyTime = ""
    var noteID = ""
    var isLike = false
    var sourceModel: OTNoteModel!
    override init() {
        super.init()
    }
    
    func setData(model: OTNoteModel) {
        self.sourceModel = model
        self.noteID = model.id
        self.title = model.title
        let lastIndex = model.contentTxt.last!.length >= 20 ? 20 : model.contentTxt.last!.length
        self.abstract = "摘要: " + model.contentTxt.last!.substringToIndex(lastIndex)
        self.modifyTime = model.modifyTime.last!.dateToString("修改时间：yyyy-MM-dd")
        if model.isLike == nil || model.isLike! == false {
            self.isLike = false
        }else{
            self.isLike = true
        }
    }
    
}
