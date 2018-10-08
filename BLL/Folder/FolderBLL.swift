//
//  FolderBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/23.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class FolderBLL: NSObject {
    let dal = FolderDAL()
    override init() {
        super.init()
    }

    func insert(with model: OTFolderModel) {
        dal.insert(with: model)
    }

    func getInfo() -> [OTFolderModel] {
        let arrInfo = dal.getData()
        var result = [OTFolderModel]()
        for eachItem in arrInfo {
            let jsonData = try! JSONSerialization.data(withJSONObject: eachItem, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonCoder = JSONDecoder()
            jsonCoder.dateDecodingStrategy = .secondsSince1970
            let model = try! jsonCoder.decode(OTFolderModel.self, from: jsonData)
            result.append(model)
        }
        return result
    }

    func deleteFolder(with folderId: String) {
        dal.deleteFolder(with: folderId)
        //delete note from notetab where inclode by this folder
        OTNoteDAL().deleteAllNote(inclodes: folderId)
    }

    func deleteAllInfo() {
        dal.deleteAllInfo()
    }
}
