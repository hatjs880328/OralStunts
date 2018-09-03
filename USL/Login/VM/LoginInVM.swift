//
//  LoginInVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import RxSwift

class LoginInVM: IIBaseVM {
    
    var couldUseAction: ((_ couldUse:Bool)->Void)!
    
    /// 输入监听
    var txtInput:PublishSubject<String> = PublishSubject<String>()
    
    /// 输出监听
    var txtOutput:Observable<(Bool,UIColor)>!
    
    /// 点击监听
    var didInput:PublishSubject<Void> = PublishSubject<Void>()
    
    var didOutput:Observable<Void>!
    
    var userNickName:String = ""
    override init() {
        super.init()
        self.txtOutput = txtInput.asObservable().map({ [weak self](strValue) -> (Bool,UIColor) in
            self?.userNickName = strValue
            if strValue.length >=  2 {
                return (true,UIColor.black)
            }
            return (false,APPDelStatic.lightGray)
        })
        self.didOutput = self.didInput.asObservable().map { [weak self]() -> Void in
            if self == nil { return }
            LoginBll().loginSuccess(self!.userNickName)
            return
        }
        
        
    }
    
}
