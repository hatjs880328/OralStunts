//
//  NoteCreatingBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/22.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

/*
 
 生命周期内创建note的类-可作为主线来看待
 
 */
class NoteCreatingBLL: NSObject {

    private override init() {
        super.init()
    }

    private static var instance: NoteCreatingBLL!

    public static func getInstance() -> NoteCreatingBLL {
        if instance == nil {
            instance = NoteCreatingBLL()
        }
        return instance
    }

    /// 创建中的otnote
    var creatingNoteModel = OTNoteModel()

    /// 查看某一个具体的note记录时的引用
    var showingNoteModel = OTNoteModel()

    /// 查看某一个具体的folder记录时的引用
    var showingFolderMoel: OTFolderModel = OTFolderModel()

    /// 创建完毕，提交到缓存后执行，下一次的是一个新的model
    private func revertModel() {
        self.creatingNoteModel = OTNoteModel()
    }

    func insertModel() {
        NoteLogicBLL().insertNoteInfo(with: self.creatingNoteModel)
        self.revertModel()
    }

    func progressModelContent(content: String, volumnList: [Int32]) {
        self.creatingNoteModel.setContexts(createTime: Date(), content: content, volumnList: volumnList)
        self.creatingNoteModel.videoUrl.append(self.creatingNoteModel.id + "~content0")
    }

    func progressModelTitle(title: String, volumeList: [Int32]) {
        self.creatingNoteModel.setTitle(title, volumeList)
        self.creatingNoteModel.titleVideoUrl = self.creatingNoteModel.id + "~title"
    }

    func setShowingModel(with id: String) {
        self.showingNoteModel = NoteLogicBLL().getNoteModelWithID(id: id)
    }
}
