//
//  CloudMineModule.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/8.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class CloudMineModule:NSObject, CloudMineIBLL {
    
    override init() {
        super.init()
    }
    
    func jumpToCloudMineVC() -> UIViewController {
        return CloudMineViewController()
    }
    
    static func singleton() -> Bool {
        return true
    }
}
