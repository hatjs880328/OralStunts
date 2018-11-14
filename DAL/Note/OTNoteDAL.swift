//
//  OTNoteDAL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/19.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import EventKit

class OTNoteDAL: NSObject {

    let tabName = "OTNoteTab"

    let pageSize: Int = 10

    override init() {
        super.init()
    }

    /// 创建表
    func createTab() {
        let sql = Model2Sql.getInstance().model2SqlWithCtg(model: CreateTabSql(), tableName: tabName)
        FMDatabaseQueuePublicUtils.executeUpdate(sql: sql)
    }

    /// 插入一条数据
    func insert(with model: CreateTabSql) {
        let delSql = "delete from \(tabName) where id = '\(model.id)' ;"
        let sql = delSql + Model2SqlInsert.getInstance().insertModelWithCtg(model: model, tableName: tabName)
        FMDatabaseQueuePublicUtils.executeUpdate(sql: sql)
    }

    /// 获取玩数据之后基本解析方法
    private func progressData(_ arr: NSMutableArray) -> [OTNoteModel] {
        var models = [OTNoteModel]()
        for eachItem in arr {
            do {
                let jsonDate = try JSONSerialization.data(withJSONObject: eachItem, options: JSONSerialization.WritingOptions.prettyPrinted)
                let decode = JSONDecoder()
                decode.dateDecodingStrategy = .secondsSince1970
                let eachModel = try decode.decode(CreateTabSql.self, from: jsonDate)
                let realModel = try JSONDecoder().decode(OTNoteModel.self, from: eachModel.txtstrInfo.data(using: String.Encoding.utf8)!)
                models.append(realModel)
            } catch {}
        }

        return models
    }

    /// 分页查找数据
    func getInfos(with page: Int, order by: String, sort type: String) -> [OTNoteModel] {
        let sql = "select * from \(tabName) order by createTime; "
        let arr = FMDatabaseQueuePublicUtils.getResultWithSql(sql: sql)

        return progressData(arr)
    }

    /// 获取没有分配文件夹的数据
    func getNonFolderData() -> [OTNoteModel] {
        let sql = "select * from \(tabName) where folderID = '' order by modifyTime desc;"
        let arr = FMDatabaseQueuePublicUtils.getResultWithSql(sql: sql)

        return progressData(arr)
    }

    /// 更新数据-批量处理文件夹
    func updateFolderDate(ids: [String], folderId: String) {
        var inIDStr = ""
        for eachItem in 0 ..< ids.count {
            if eachItem == ids.count - 1 {
                inIDStr += "'\(ids[eachItem])'"
            } else {
                inIDStr += "'\(ids[eachItem])',"
            }
        }
        let sql = "update \(tabName) set folderID = '\(folderId)' where id in (\(inIDStr));"
        FMDatabaseQueuePublicUtils.executeUpdate(sql: sql)
    }

    /// 分页获取没有添加到文件夹的数据-按照时间排序
    func getNonFolderData(page: Int, limit: Int) -> [OTNoteModel] {
        let sql = "select * from \(tabName) where folderID = '' order by modifyTime desc Limit \(limit) Offset \(page)"
        let arr = FMDatabaseQueuePublicUtils.getResultWithSql(sql: sql)

        return progressData(arr)
    }

    /// 根据文件夹ID获取文件夹下面的数据
    func getFolderInfos(with folderID: String) -> [OTNoteModel] {
        let sql = "select * from \(tabName) where folderID = '\(folderID)' order by createTime desc;"
        let arr = FMDatabaseQueuePublicUtils.getResultWithSql(sql: sql)

        return progressData(arr)
    }

    /// 搜搜
    func getInfos(with whereSql: String) -> [OTNoteModel] {
        //%contentTxt%a%],"id%
        let sql = "select * from \(tabName) where txtstrInfo like '%contentTxt%\(whereSql)%],\"id%';"
        let arr = FMDatabaseQueuePublicUtils.getResultWithSql(sql: sql)

        return progressData(arr)
    }

    /// 搜索某一个model  根据id
    func getInfoByid(id: String) -> [OTNoteModel] {
        let sql = "select * from \(tabName) where id = '\(id)' ;"
        let arr = FMDatabaseQueuePublicUtils.getResultWithSql(sql: sql)

        return progressData(arr)
    }

    /// 删除一条数据，根据id
    func deleteOneNote(with id: String) {
        let sql = "delete from \(tabName) where id = '\(id)';"
        FMDatabaseQueuePublicUtils.executeUpdate(sql: sql)
    }

    /// 删除note,文件夹id为参数所示时
    func deleteAllNote(inclodes folder: String) {
        let sql = "delete from \(tabName) where folderID = '\(folder)';"
        FMDatabaseQueuePublicUtils.executeUpdate(sql: sql)
    }

    /// 清空表信息
    func deleteAllInfo() {
        let sql = "delete from \(tabName);"
        FMDatabaseQueuePublicUtils.executeUpdate(sql: sql)
    }

    /// 根据便签生成ekevent数组
    func getDataFollowDate(startDate: Date, endDate: Date) -> [EKEvent] {
        let startTime = startDate.timeIntervalSince1970
        let endTime = endDate.timeIntervalSince1970
        let getSQL = "select * from \(tabName) where modifyTime > \(startTime) and modifyTime < \(endTime) order by modifyTime desc;"
        let arr = FMDatabaseQueuePublicUtils.getResultWithSql(sql: getSQL)
        let otnoteModels = progressData(arr)
        var realResult = [EKEvent]()
        for eachItem in otnoteModels {
            let realModel = EKEvent(eventStore: DingTalkGetEventCalender().eventDB)
            realModel.title = eachItem.title
            realModel.location = eachItem.id
            let length = eachItem.contentTxt.last!.length > 12 ? 12 : eachItem.contentTxt.last!.length
            realModel.notes = eachItem.contentTxt.last!.substringToIndex(length)
            realModel.startDate = eachItem.modifyTime.last!
            realModel.endDate = eachItem.modifyTime.last!
            realModel.isAllDay = false
            realResult.append(realModel)
        }

        return realResult
    }
}
