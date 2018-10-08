//
//  IIAPIStruct.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/6/13.
//  Copyright © 2018年 Elliot. All rights reserved.
//

import Foundation

class IIAPIStruct: NSObject {

    //Temporary token api
    lazy var temporaryToken = "\(IIBizConfig.evernoteAPIHost)oauth?oauth_callback=localhost&oauth_consumer_key=\(IIBizConfig.evernoteKey)&oauth_nonce=3166905818410889691&oauth_signature=T0+xCYjTiyz7GZiElg1uQaHGQ6I=&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1429565574&oauth_version=1.0"

    ///Temporary token api示例
    lazy var temporaryTokenIns = "https://sandbox.evernote.com/oauth?oauth_callback=http://www.foo.com&oauth_consumer_key=sample-api-key-4121&oauth_nonce=3166905818410889691&oauth_signature=T0+xCYjTiyz7GZiElg1uQaHGQ6I=&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1429565574&oauth_version=1.0"

}
