//
//  FolderTabVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/23.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import RxSwift

class FolderTabVM: IIBaseVM {
    
    var cellInfos: [FolderCellVModel] = [] {
        didSet{
            if self.reloadAction == nil { return }
            //self.reloadAction()
        }
    }
    
    var reloadAction:(()->Void)!
    
    var selectCellInput = PublishSubject<(noteid:String,isAdd: Bool,index:IndexPath)>()
    
    var selectCelloutput: Observable<(index:IndexPath,isAdd:Bool)>!
    
    var selectedCellIDS: Dictionary<String,String> = [:]
    
    override init() {
        super.init()
        self.selectCelloutput = self.selectCellInput.asObservable().map({ [weak self](folderNoteID,isAdd,index) -> (IndexPath,Bool) in
            if isAdd {
                self?.selectedCellIDS.removeAll()
                self?.selectedCellIDS[folderNoteID] = ""
            }else{
                self?.selectedCellIDS.removeAll()
            }
            return (index,isAdd)
        })
    }
    
    func getModel(with index: IndexPath)->FolderCellVModel {
        return self.cellInfos[index.row]
    }
    
    func deleateOneFolder(with index: IndexPath) {
        let item = self.cellInfos[index.row]
        FolderBLL().deleteFolder(with: item.sourceNote.id)
        self.cellInfos.remove(at: index.row)
    }
    
    func getData() {
        let cellModels = FolderBLL().getInfo()
        var result = [FolderCellVModel]()
        for eachItem in cellModels {
            let model = FolderCellVModel()
            model.createData(with: eachItem)
            result.append(model)
        }
        self.cellInfos = result
    }
    
}

class FolderCellVModel: NSObject,Codable {
    
    var title = ""
    
    var createTime = ""
    
    var count = ""
    
    var sourceNote: OTFolderModel!
    
    override init() {
        super.init()
    }
    
    func createData(with model: OTFolderModel) {
        self.sourceNote = model
        self.title = model.title
        self.createTime = model.createTime.dateToString("修改时间:yyyy-MM-dd HH:mm")
        self.count = "文件数:\(model.contentCount)"
    }
}
