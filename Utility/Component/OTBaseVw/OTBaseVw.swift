//
//  OTBaseVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/20.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

/// 自创建的view的父类
class OTBaseVw: UIView {
    
    var fatherVw: UIView?
    
    var topVw: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init the otbasevw fail...")
    }
}
