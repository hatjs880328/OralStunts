//
//  LastedIBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/8.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


/*
 关于个人中心模块的说明：
 1.仅对外暴露一个跳转API
 2.基础数据来源于MODEL+dal无需引入其他业务模块
 3.引用的模块有 MODEL层基础功能模块（wcdb）
 
 关于个人中心demo开发的总结
 1.对于不合适的原型设计\UI设计需要提出
 2.尽量能有原型评审工作
 */


/// 个人中心功能模块对外部暴露方法接口
@objc protocol CloudMineIBLL: BHServiceProtocol {
    
    func jumpToCloudMineVC()->UIViewController
    
    @objc optional func getCloudMineCell(style: UITableViewCellStyle,reuseID:String?)->UITableViewCell
    
    
}
