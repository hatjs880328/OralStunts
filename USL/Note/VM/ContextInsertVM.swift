//
//  ContextInsertVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/22.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import RxSwift

class ContextInsertVM: IIBaseVM {

    var titlePublisher: PublishSubject<String> = PublishSubject<String>()

    var volumePublisher: PublishSubject<Int32> = PublishSubject<Int32>()

    var rememberStr = ""

    // 创建时信号
    var dongInput = PublishSubject<(String, [Int32])>()

    var outPutSignal: Observable<Bool>!

    // 编辑时信号
    var reCreateInput = PublishSubject<(String, [Int32])>()

    var reCreateOutput: Observable<Bool>!

    override init() {
        super.init()
        self.outPutSignal = dongInput.asObservable().map({ (str, volumnList) -> Bool in
            if str == "" {

                return false
            }
            NoteCreatingBLL.getInstance().progressModelContent(content: str, volumnList: volumnList)
            NoteCreatingBLL.getInstance().insertModel()

            return true
        })

        self.reCreateOutput = reCreateInput.asObservable().map({ (str, volumeList) -> Bool in
            if str == "" {

                return false
            }
            NoteLogicBLL().editNoteInfo(content: str, volumeList: volumeList)

            return true
        })
    }

    func postTitle(_ str: String) {
        rememberStr += str
        self.titlePublisher.onNext(rememberStr)
    }

    func postVolume(_ value: Int32) {
        self.volumePublisher.onNext(value)
    }

}
