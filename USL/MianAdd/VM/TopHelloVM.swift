//
//  TopHelloVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import RxSwift

class TopHelloVM: NSObject {
    
    var outPut: Observable<String>!
    
    override init() {
        super.init()
        self.outPut = Observable.create({ (observer) -> Disposable in
            observer.onNext("你好，\(MineBLL().getUserInfo().nickName)")
            return Disposables.create()
        })
    }
    
    
}
