//
//  CloudMineDAL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/8.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


/// 此model对应的dal这一层数据是从 缓存中获取出来的<新版如果放到了wdbc中，则是从数据库获取>
class CloudMineDAL: NSObject {
    
    override init() {
        super.init()
    }
    
    func createTab() {
        
    }
    
    func updateTab() {
        
    }
    
    /// 提醒：按照如此分层，在API提供方没有处理完毕数据时，可以在dal这一层很方便的创造假数据，当api处理完毕之后，只需要修改这一层即可
    /// 提醒：加入假的数据和真正数据最后不相同，那么需要处理的点是MODEL\VModel\view层的setdata方法<也有可能只需要处理model\vmodel>
    func getUserInfo()->CloudMineModel {
        let userInfomodel = CloudMineModel()
        userInfomodel.companyName = "Insupr"
        userInfomodel.imagePlaceHolder = ""
        userInfomodel.name = "Noah_Shan"
        userInfomodel.imageUrl = "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3475796438,2685973568&fm=27&gp=0.jpg"
        
        return userInfomodel
    }
    
    func updateUserInfo(with userModel: CloudMineModel) {
        
    }
    
    func deleteUserInfo() {
        
    }
}
