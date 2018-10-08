//
//  MineDAL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class MineDAL: NSObject {

    var tabName: String = "OTUserInfo"
    override init() {
        super.init()
    }

    func createTabWithModel() {
        let createTabSQL = Model2Sql.getInstance().model2SqlWithCtg(model: OTUserInfo(), tableName: tabName)
        FMDatabaseQueuePublicUtils.executeUpdate(sql: createTabSQL)
    }

    func insertOneInfo(with model: OTUserInfo) {
        let deleteSQL = "delete from \(tabName);"
        let insertSQL = deleteSQL + Model2SqlInsert.getInstance().insertModelWithCtg(model: model, tableName: tabName)
        FMDatabaseQueuePublicUtils.executeUpdate(sql: insertSQL)
    }

    func getUserInfo() -> OTUserInfo {
        let getSQL = "select * from \(tabName);"
        let resultArr = FMDatabaseQueuePublicUtils.getResultWithSql(sql: getSQL)
        let obj = resultArr.firstObject as! NSDictionary
        let jsonData = try! JSONSerialization.data(withJSONObject: obj, options: JSONSerialization.WritingOptions.prettyPrinted)
        let model = try! JSONDecoder().decode(OTUserInfo.self, from: jsonData)

        return model
    }

    /// 更新性别
    func updateGender(gender: String) {
        let updateSql = "update \(tabName) set gender = '\(gender)';"
        FMDatabaseQueuePublicUtils.executeUpdate(sql: updateSql)
    }

    /// 更新留言信息
    func updateNote(note: String) {
        let updateSql = "update \(tabName) set noteInfo = '\(note)';"
        FMDatabaseQueuePublicUtils.executeUpdate(sql: updateSql)
    }

    /// 更新是否提示信息
    func updateAlertInfo(note: Bool) {
        let updateSql = "update \(tabName) set alertHelpInfo = '\(note)';"
        FMDatabaseQueuePublicUtils.executeUpdate(sql: updateSql)
    }

}
