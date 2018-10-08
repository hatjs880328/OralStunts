//
//  LoginDAL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class LoginDAL: NSObject {

    let key = "useAppCount"

    override init() {
        super.init()
    }

    func setUseTime() {
        let oldValue = self.getUseTime()
        UserDefaults.standard.set(oldValue + 1, forKey: key)
    }

    func getUseTime() -> Int {
        if UserDefaults.standard.object(forKey: key) == nil {
            UserDefaults.standard.set(0, forKey: key)
            return 0
        } else {
            return UserDefaults.standard.object(forKey: key) as! Int
        }
    }
}
