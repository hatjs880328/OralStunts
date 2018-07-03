//
//  OTSearchVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class OTSearchVM: IIBaseVM {
    
    var didEditingPub:PublishSubject<Void> = PublishSubject<Void>()
    
    var didEditingOB:Observable<Void>!
    
    var searchFdInput: PublishSubject<String> = PublishSubject<String>()
    
    var searchFdOutput:Observable<Void>!
    
    weak var con: UIViewController!
    
    override init() {
        super.init()
        self.didEditingOB = didEditingPub.asObservable().map({ () -> Void in
            return
        })
        self.searchFdOutput = self.searchFdInput.asObservable().map({ [weak self](strInfo) -> Void in
            //发起搜索
            if self?.con == nil || self == nil { return }
            if let cons = self!.con as? SearchViewController {
                cons.tabVw.vm.requestDataByWhereSql(sql: strInfo)
            }
        })
    }
    
    
}
