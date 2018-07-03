//
//  ThirdLoginDAL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/19.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

class ThirdLoginDAL: NSObject {
    func getTemporaryToken() {
        IIHTTPRequest.startRequest(method: IIHTTPMethod.get, url: IIAPIStruct().temporaryTokenIns, params: nil, successAction: { (response) in
            print(response)
        }) { (errorInfo) in
            print(errorInfo)
        }
    }
}
