//
//  TtileInsertVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/22.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import RxSwift

class TtileInsertVM: IIBaseVM {

    var titlePublisher: PublishSubject<String> = PublishSubject<String>()

    var jumpInput: PublishSubject<(String, [Int32])> = PublishSubject<(String, [Int32])>()

    var outPut: Observable<Bool>!

    var volumePublisher: PublishSubject<Int32> = PublishSubject<Int32>()

    var rememberStr = ""

    override init() {
        super.init()
        self.outPut = self.jumpInput.asObservable().map { (strValue, volumnArr) -> Bool in
            if strValue == "" {

                return false
            }
            NoteCreatingBLL.getInstance().progressModelTitle(title: strValue, volumeList: volumnArr)

            return true
        }
    }

    func postTitle(_ str: String) {
        rememberStr += str
        self.titlePublisher.onNext(rememberStr)
    }

    func postVolume(_ value: Int32) {
        self.volumePublisher.onNext(value)
    }

}
