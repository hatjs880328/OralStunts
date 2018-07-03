//
//  OTFolderModel.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/23.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class OTFolderModel: NSObject,Codable {
    
    var id = NSUUID().uuidString
    
    var title = ""
    
    var createTime = Date()
    
    var contentCount:Int = 0
    
    var modifyTime = Date()
    
    override init() {
        super.init()
    }
}
