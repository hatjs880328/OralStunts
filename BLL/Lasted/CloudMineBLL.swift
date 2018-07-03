//
//  CloudMineBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/8.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


class CloudMineBLL: NSObject {
    
    override init() {
        super.init()
    }
    
    /// 获取缓存在本地的用户信息<这一层处理业务逻辑>
    /// 加入在获取这个model的过程中需要添加一些系统信息，如：ios版本，屏幕大小一类的信息到model的属性中，在这里处理
    func getDBData()->CloudMineTabVwCellModel {
        let userInfo = CloudMineDAL().getUserInfo()
        
        return CloudMineTabVwCellModel(with: userInfo)
    }
    
    /// 更改用户头像
    func changeUserImg(with urlStr: String) {
        // dal.update...
    }
    
    // 其他关于个人中心的业务处理方法
}
