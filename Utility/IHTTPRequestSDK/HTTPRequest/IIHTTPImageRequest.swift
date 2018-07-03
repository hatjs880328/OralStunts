//
//  IIHTTPImageRequest.swift
//  IIAlaSDK
//  图片上传类
//  Created by Noah_Shan on 2018/5/31.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


open class IIHTTPImageRequest: NSObject  {
    
    /// 上传图片
    ///
    /// - Parameters:
    ///   - url:                 URL
    ///   - imageDataArr:        图片数据数组
    ///   - imageNameArr:        图片名称数组
    ///   - header:              HEADER
    ///   - successAction:       成功action
    ///   - errorAction:         失败action
    open class func uploadImage(url:String, imageDataArr : [Data] ,imageNameArr : [String] ,header:[String : String]? = nil,successAction:@escaping (_ response:ResponseClass)->Void,errorAction:@escaping (_ errorType:ErrorInfo)->Void){
        if !IIHTTPRequestExtension.progressNoNetWork() {
            errorAction(ErrorInfo(type: ERRORMsgType.noConnection))
            return
        }
        let httpHeader = IIHTTPRequestExtension.analyzeHTTPHeader(header)
        upload(multipartFormData: { (multipartFormData) in
            for i in 0 ..< imageDataArr.count {
                //如果是单纯的键值对应该使用multipartFormData.append(data:Data,name:String)
                let data = imageDataArr[i]
                let fileName = imageNameArr[i]
                multipartFormData.append(data, withName: "imgUrl", fileName: fileName, mimeType: "image/*")
            }
        }, to: url, headers: httpHeader) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
