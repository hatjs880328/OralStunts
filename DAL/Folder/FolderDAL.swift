//
//  FolderDAL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/23.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


class FolderDAL: NSObject {
    
    let tabName: String = "OTFolderTab"
    
    override init() {
        super.init()
    }
    
    func createTab() {
        let createSQL = Model2Sql.getInstance().model2SqlWithCtg(model: OTFolderModel(), tableName: tabName)
        FMDatabaseQueuePublicUtils.executeUpdate(sql: createSQL)
    }
    
    func insert(with model: OTFolderModel) {
        let sql = Model2SqlInsert.getInstance().insertModelWithCtg(model: model, tableName: tabName)
        FMDatabaseQueuePublicUtils.executeUpdate(sql: sql)
    }
    
    func getData()->NSMutableArray {
        let sql = "select * from \(tabName) order by modifyTime desc;"
        let result = FMDatabaseQueuePublicUtils.getResultWithSql(sql: sql)
        return result
    }
    
    func changeModifyTime(with id: String) {
        let sql = "update \(tabName) set modifyTime = '\(Date().timeIntervalSince1970)' where id = '\(id)';"
        FMDatabaseQueuePublicUtils.executeUpdate(sql: sql)
    }
    
    func deleteFolder(with id:String) {
        let sql = "delete from \(tabName) where id = '\(id)';"
        FMDatabaseQueuePublicUtils.executeUpdate(sql: sql)
    }
}
