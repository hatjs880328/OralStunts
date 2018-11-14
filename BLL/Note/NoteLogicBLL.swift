//
//  NoteLogicBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/25.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class NoteLogicBLL: NSObject {

    var dal = OTNoteDAL()

    /// progress sql model
    func progressSQLModel(with model: OTNoteModel) -> CreateTabSql {
        let realModel = CreateTabSql()
        realModel.id = model.id
        realModel.title = model.title
        realModel.folderID = model.folderID
        realModel.txtstrInfo = String(data: try! JSONEncoder().encode(model), encoding: String.Encoding.utf8)!
        realModel.createTime = model.createTime
        realModel.modifyTime = model.modifyTime.last!
        return realModel
    }

    /// first insert model
    func insertNoteInfo(with model: OTNoteModel) {
        let sqlModel = progressSQLModel(with: model)
        dal.insert(with: sqlModel)
    }

    func getNoteInfo(page: Int, order: String, sortType: String) -> [OTNoteModel] {
        return dal.getInfos(with: page, order: order, sort: sortType)
    }

    /// 获取没有分配文件夹的数据
    func getNonFolderData() -> [OTNoteModel] {
        return dal.getNonFolderData()
    }

    /// 分页获取没有分配文件夹的数据
    func getNonFolderData(limit: Int, page: Int) -> [OTNoteModel] {
        return dal.getNonFolderData(page: page, limit: limit)
    }

    func getNoteByWhereSQL(sqlStr: String) -> [OTNoteModel] {
        if sqlStr == "" {
            return []
        }
        return dal.getInfos(with: sqlStr)
    }

    /// 获取某文件夹下面的便签数据
    func loadData(with folderID: String) -> [OTNoteModel] {
        if folderID == "" { return [] }

        return dal.getFolderInfos(with: folderID)
    }

    /// 根据id获取某一个model
    func getNoteModelWithID(id: String) -> OTNoteModel {
        return dal.getInfoByid(id: id).first!
    }

    /// 编辑、修改时，插入新的content 、 modifytime、 volumeList
    func editNoteInfo(content: String, volumeList: [Int32]) {
        let newOTModel = NoteCreatingBLL.getInstance().showingNoteModel
        var realContent = content.progressSQLFormat()
        newOTModel.setNewContents(modifyTime: Date(), content: realContent, volumnList: volumeList)
        newOTModel.videoUrl.append("\(newOTModel.id)~content\(newOTModel.videoUrl.count)")
        self.insertNoteInfo(with: newOTModel)
    }

    /// 收藏与不收藏
    func likeOneModel(isLike: Bool, noteID: [String]) {
        for eachItem in noteID {
            let smallModel = self.getNoteModelWithID(id: eachItem)
            smallModel.isLike = isLike
            self.insertNoteInfo(with: smallModel)
        }
    }

    /// 获取收藏的数据信息
    func getFavData() -> [OTNoteModel] {
        let models = dal.getInfos(with: 0, order: "", sort: "")
        var result = [OTNoteModel]()
        for eachItem in models {
            if eachItem.isLike == true {
                result.append(eachItem)
            }
        }
        return result
    }

    /// 将便签移动到某个文件夹下
    func moveNote2Folder(ids: [String], folderID: String?, errorAction: (_ isFail: Bool) -> Void) {
        if folderID == nil || folderID! == "" {
            errorAction(true)
            return
        }
        for eachItem in ids {
            let model = dal.getInfoByid(id: eachItem)
            model.first!.folderID = folderID!
            let sqlModel = progressSQLModel(with: model.first!)
            dal.insert(with: sqlModel)
        }
        //dal.updateFolderDate(ids: ids, folderId: folderID!)
        // 修改folder表的modifytime
        FolderDAL().changeModifyTime(with: folderID!)
        errorAction(false)
    }

    /// 删除一条数据
    func deleateOneNote(with id: String) {
        dal.deleteOneNote(with: id)
        NoteCreatingBLL.getInstance().showingNoteModel = OTNoteModel()
    }

    func deleteAllInfo() {
        dal.deleteAllInfo()
    }
}
