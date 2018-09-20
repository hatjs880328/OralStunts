//
//  NoteWaterFallVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/19.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

/// 瀑布流的vm-继承自 normal-list-vm
class NoteWaterFallVM: SearchVCTabVM {
    
    /// 初始化为第0页
    var pageNo: Int = 0
    
    var pageLimit: Int = 20
    
    /// 瀑布流数据源
    var waterFallDatasource: [SearchvcVmodel] = [] {
        didSet{
            if self.addNewDataAction == nil { return }
            self.addNewDataAction!()
        }
    }
    
    
    
    override init() {
        super.init()
    }
    
    /// 每一次获取10个ITEM-vm记录pagenum
    func getWaterFallData() {
        let dataArr = NoteLogicBLL().getNonFolderData(limit: pageLimit, page: pageNo)
        //self.pageNo += 1
        var result = [SearchvcVmodel]()
        for eachItem in dataArr {
            let model = SearchvcVmodel()
            model.setData(model: eachItem)
            result.append(model)
        }
        //self.waterFallDatasource.append(contentsOf: result)
        self.waterFallDatasource = result
    }
}
