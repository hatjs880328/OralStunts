//
//  OTNoteModel.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/19.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

// vip model
class OTNoteModel: NSObject,Codable {
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
    
    func setTitle(_ str: String, _ volumeList: [Int32]) {
        self.title = str
        self.titleVideoNumberArr = volumeList
    }
    
    func setContexts(createTime: Date,content:String,volumnList:[Int32]) {
        self.createTime = createTime
        self.contentTxt.append(content)
        self.modifyTime.append(createTime)
        self.videoNumberArr.append(volumnList)
    }
    
    func setNewContents(modifyTime:Date,content:String,volumnList:[Int32]) {
        self.contentTxt.append(content)
        self.modifyTime.append(modifyTime)
        self.videoNumberArr.append(volumnList)
    }
}

class CreateTabSql:NSObject,Codable {
    var id: String = ""
    var txtstrInfo: String = ""
    var createTime: Date = Date()
    var modifyTime: Date = Date()
    var folderID:String = ""
}
