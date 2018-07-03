//
//  FeedBackVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/28.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class FeedBackVM: IIBaseVM {
    var fieldInput:PublishSubject<String> = PublishSubject<String>()
    var fieldOutput: Observable<(String,String)>!
    var btnInput: PublishSubject<Void> = PublishSubject<Void>()
    var tapOutput: Observable<Void>!
    
    var result = ""
    override init() {
        super.init()
        
        self.fieldOutput = fieldInput.asObservable().map({ [weak self](strValue) -> (String,String) in
            if strValue.length > 80 {
                self?.result = (strValue.substringToIndex(80))
                return (strValue.substringToIndex(80),"80/80")
            }
            self?.result = strValue
            return (strValue,"\(strValue.length)/80")
        })
        
        self.tapOutput = self.btnInput.asObservable().map({ [weak self](tapVoid) -> Void in
            if self == nil { return }
            APPDelBLL().reportCustomExp(info: [self!.result])
        })
    }
    
}
