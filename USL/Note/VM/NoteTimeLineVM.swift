//
//  NoteTimeLineVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/24.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


class NoteTimeLineVM: IIBaseVM {
    
    //var noteModel:SearchvcVmodel!
    
    var cellInfo:[NoteTimelineVModel] = [] {
        didSet{
            if self.reloadAction == nil { return }
            self.reloadAction()
        }
    }
    
    var reloadAction: (()->Void)!
    
    override init() {
        super.init()
    }
    
    func getModel(with index: IndexPath)-> NoteTimelineVModel {
        return self.cellInfo[index.row]
    }
    
    func getData() {
        let result = NoteLogicBLL().getNoteModelWithID(id: NoteCreatingBLL.getInstance().showingNoteModel.id)
        var realResult = [NoteTimelineVModel]()
        for i in 0 ..< result.contentTxt.count {
            let model = NoteTimelineVModel(model: result, txt: result.contentTxt[i],modifyTime:result.modifyTime[i],contentVolumeArr:result.videoNumberArr[i])
            realResult.append(model)
        }
        self.cellInfo = realResult
    }
    
}

class NoteTimelineVModel: NSObject {
    var createTime = ""
    
    var txt = ""
    
    var cellHeight: CGFloat = 0
    
    var contentVolumeArr = [Int32]()
    
    init(model: OTNoteModel,txt:String,modifyTime:Date,contentVolumeArr:[Int32]) {
        super.init()
        self.createTime = modifyTime.dateToString("编辑时间: yyyy-MM-dd HH:mm")
        self.txt = txt
        let cellWidth = APPDelStatic.aWeight - 36 - 15 * APPDelStatic.sizeScale
        let realHeight = IITextExtension.textLength(text: self.txt, font: APPDelStatic.uiFont(with: 11), eachLineWeight: cellWidth)
        self.cellHeight = (realHeight + 90) * APPDelStatic.sizeScale
        self.contentVolumeArr = contentVolumeArr
    }
}
