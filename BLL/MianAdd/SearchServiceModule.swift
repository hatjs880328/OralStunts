//
//  SearchServiceModule.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

/// 搜索模块对外暴露的方法
class SearchServiceModule: ModuleGodFather {
    
    /*
        真正暴露的方法开始了-
    */
    @objc func jumpToSearchVC(params: [AnyHashable:Any]) {
        if let fromVC = params["fromVC"] as? UIViewController {
            let con = SearchViewController()
            con.hidesBottomBarWhenPushed = true
            fromVC.navigationController?.pushViewController(con, animated: true)
        }
    }
}
