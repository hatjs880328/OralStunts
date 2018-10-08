//
//  OTCloudFatherModel.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/30.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation
import HandyJSON

/*
 notes:
 1.所有存储到icloud中的对象的父类-为了从cloud获取下数据时，对数据进行转换
 
 
 */
class OTCloudFatherModel: HandyJSON {

    required init() {}

    /// 必须要重写的一个方法
    func initWith(record: CKRecord) -> OTCloudFatherModel {
        let ins = OTCloudFatherModel()
        return ins
    }

}
