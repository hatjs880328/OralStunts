//
//  OTNoteModel.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/19.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

// vip model
class OTNoteModel: NSObject, Codable {
    /// 主键ID
    var id = NSUUID().uuidString
    /// 标题
    var title = ""
    /// 创建时间
    var createTime = Date()
    /// 修改时间
    var modifyTime = [Date]()
    /// 图片url-二维
    var imageURL = [[String]]()
    /// 正文
    var contentTxt = [String]()
    /// content-video本地文件路径
    var videoUrl = [String]()
    /// video音频编码数组-二维
    var videoNumberArr = [[Int32]]()
    /// 标题的video音频编码
    var titleVideoNumberArr = [Int32]()
    /// 标题video路径
    var titleVideoUrl = ""
    /// folderid-文件夹id
    var folderID = ""
    /// 收藏属性-默认不收藏
    var isLike: Bool?

    func setTitle(_ str: String, _ volumeList: [Int32]) {
        self.title = str
        self.titleVideoNumberArr = volumeList
    }

    func setContexts(createTime: Date, content: String, volumnList: [Int32]) {
        self.createTime = createTime
        self.contentTxt.append(content)
        self.modifyTime.append(createTime)
        self.videoNumberArr.append(volumnList)
    }

    func setNewContents(modifyTime: Date, content: String, volumnList: [Int32]) {
        self.contentTxt.append(content)
        self.modifyTime.append(modifyTime)
        self.videoNumberArr.append(volumnList)
    }
}

class CreateTabSql: OTCloudFatherModel, Codable, Equatable {

    var id: String = ""
    var title: String = ""
    var txtstrInfo: String = ""
    var createTime: Date = Date()
    var modifyTime: Date = Date()
    var folderID: String = ""

    override func initWith(record: CKRecord) -> CreateTabSql {
        let ins = CreateTabSql()
        ins.id = record.recordID.recordName
        ins.title = record.value(forKey: "title") as! String
        ins.folderID = record.value(forKey: "folderID") as! String
        ins.txtstrInfo = record.value(forKey: "txtstrInfo") as! String
        ins.createTime = record.value(forKey: "createTime") as! Date
        ins.modifyTime = record.value(forKey: "title") as! Date
        return ins
    }

    static func ==(lhs: CreateTabSql, rhs: CreateTabSql) -> Bool {
        return lhs.id == rhs.id
    }
}

class SearchvcVmodel: NSObject {

    var title = ""
    var abstract = ""
    var modifyTime = ""
    var noteID = ""
    var isLike = false
    /// 瀑布流单个ITEM高度
    var waterFallHeight: CGFloat = 0.0
    /// realmodel
    var sourceModel: OTNoteModel!
    /// 是否被选中
    var isSelected: Bool = false

    override init() {
        super.init()
    }

    @discardableResult
    func setData(model: OTNoteModel)->SearchvcVmodel {
        self.sourceModel = model
        self.noteID = model.id
        self.title = model.title
        let lastIndex = model.contentTxt.last!.length >= 20 ? 20 : model.contentTxt.last!.length
        self.abstract = "摘要: " + model.contentTxt.last!.substringToIndex(lastIndex)
        self.modifyTime = model.modifyTime.last!.dateToString("最后修改时间：yyyy-MM-dd")
        if model.isLike == nil || model.isLike! == false {
            self.isLike = false
        } else {
            self.isLike = true
        }
        self.waterFallHeight = 72.0 + CGFloat(model.contentTxt.count * 18)
        return self
    }

}
