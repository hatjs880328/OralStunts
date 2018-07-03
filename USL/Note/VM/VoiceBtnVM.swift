//
//  VoiceBtnVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/22.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

/// 创建便签的时间轴
///
/// - title: 创建标题
/// - content: 创建正文
/// - reContent: 再次编辑正文
enum WhichStepCreatingNote:String {
    case title = "按住、读出你的标题"
    case content = "按住、读出你的正文信息"
    case reContent = "按住、再读出你的正文信息"
}

class VoiceBtnVM: IIBaseVM {
    
    var voiceService:NoteBLL!
    
    // 结果action
    var resultAction: ((_ resultInfo:String)->Void)! {
        didSet{
            self.voiceService.resultAction = self.resultAction
        }
    }
    
    // 音量action
    var volumeAction: ((_ volumeNow:Int32)->Void)! {
        didSet{
            self.voiceService.volumeAction = self.volumeAction
        }
    }
    
    var startWarningTxt:String = ""
    
    var listeningTxt:String = "听写中..."
    
    var warningTxtChangeAction:((_ txt:String)->Void)!
    
    var whichStepCreatingNote: WhichStepCreatingNote!
    
    var videoStr = ""
    
    init(_ warningTxt:String) {
        super.init()
        startWarningTxt = warningTxt
        progressWhichStep(warningTxt)
        createVoiceService(by: self.whichStepCreatingNote)
    }
    
    func progressWhichStep(_ stepRawvalue:String) {
        switch stepRawvalue {
        case WhichStepCreatingNote.title.rawValue:
            self.whichStepCreatingNote = WhichStepCreatingNote.title
        case WhichStepCreatingNote.content.rawValue:
            self.whichStepCreatingNote = WhichStepCreatingNote.content
        default:
            self.whichStepCreatingNote = WhichStepCreatingNote.reContent
        }
    }
    
    /// 根据目前是哪一步来给音频文件命名
    ///
    /// - Parameter step: 枚举-第几步
    func createVoiceService(by step:WhichStepCreatingNote) {
        switch step {
        case .title:
            self.videoStr = "\(NoteCreatingBLL.getInstance().creatingNoteModel.id)~title"
        case .content:
            self.videoStr = "\(NoteCreatingBLL.getInstance().creatingNoteModel.id)~content0"
        default:
            self.videoStr = "\(NoteCreatingBLL.getInstance().showingNoteModel.id)~content\(NoteCreatingBLL.getInstance().showingNoteModel.contentTxt.count)"
        }
        self.voiceService = NoteBLL(with: self.videoStr)
    }
    
    func start() {
        self.voiceService.startService()
        if self.warningTxtChangeAction == nil { return }
        self.warningTxtChangeAction(listeningTxt)
    }
    
    func stop() {
        self.voiceService.stopService()
        if self.warningTxtChangeAction == nil { return }
        self.warningTxtChangeAction(startWarningTxt)
    }
    
    
}
