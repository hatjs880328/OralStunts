//
//  TimeLineTabCellVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/31.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class TimeLineTabCellVM: IIBaseVM {

    var playUtility: NoteVedioPlayBLL!

    override init() {
        super.init()
        self.playUtility = NoteVedioPlayBLL()
    }

    func playVedio(with index: IndexPath) {
        let name = NoteCreatingBLL.getInstance().showingNoteModel.videoUrl[index.row]
        self.playUtility.playVideo(with: name)
    }

    func setAction(action:@escaping () -> Void) {
        //self.endAction = action
        self.playUtility.playEndAction = action
    }

}
