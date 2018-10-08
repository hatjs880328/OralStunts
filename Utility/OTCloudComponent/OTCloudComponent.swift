//
//  OTCloudComponent.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/21.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

/*
 cloud kit 组件封装
 FEATURE:
 1.
 
 
 
 2018-9-21
 
 */

class OTCloudComponent: NSObject {

    override init() {
        super.init()
    }

    /// 初始化cloudkit
    func initTheCloudKit() {
        let container = CKContainer.default()
        let pubDb = container.publicCloudDatabase
    }

    /// 创建表
    func createTab(name: String) {
        let record = CKRecord(recordType: name)
    }

    /// 插入数据[key-value方式插入]
    func insertValueForTab(values: [String: Any], tab: CKRecord) {
        for eachItem in values {
            tab.setValue(eachItem.value, forKey: eachItem.key)
        }
    }

    /// 先创建一个url-将图片存储到沙盒中； 之后再创建ckasset
    func inertIMG2Asset(img: UIImage, imgName: String, tab: CKRecord, key: String) {
//        let localPath:String = IIImageUtility().saveImageToSDDiskPath(img: img, imageName: imgName)
//        let asset = CKAsset(fileURL: URL(fileURLWithPath: localPath))
//        tab.setValue(asset, forKey: key)
    }

    /// 反序列化图片数据
    func decodeImg(tab: CKRecord, key: String) -> UIImage? {
        if let asset = tab.object(forKey: key) as? CKAsset {
            let img = UIImage(contentsOfFile: asset.fileURL.path)
            return img
        } else {
            return nil
        }
    }

}
