//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// IICacheStorage.swift
//
// Created by    Noah Shan on 2018/6/15
// InspurEmail   shanwzh@inspur.com
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *

import Foundation

/// 用来存储库名字，key名字
class IICacheStorage: NSObject {

    /// 缓存库名称
    @objc lazy var iiCacheStorageName = "impCloud+CacheStorage"

    /// 个人中心-tablist数据源缓存key
    @objc lazy var cloudMinePersonCenterTabList = "cloudMinePersonCenterTabList"

    /// 发现-卡包信息
    @objc lazy var discoveryCardsList = "discoveryCardsList"

    /// 预制的note添加
    @objc lazy var preNoteInsert = "preNoteInsert"

    /// 是否登陆过APP
    @objc lazy var isloginApp = "isloginApp"

    override init() {
        super.init()
    }
}
