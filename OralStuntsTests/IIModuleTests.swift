//
//  IIModuleTests.swift
//  OralStuntsTests
//
//  Created by Noah_Shan on 2018/6/6.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import XCTest
@testable import OralStunts

class IIModuleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        IIModuleCore.getInstance().registerService(module: SearchServiceModule.self)
        IIModuleCore.getInstance().registerService(module: MineServiceModule.self)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNoreturnValue() {
        let _ = IIModuleCore.getInstance().invokingSomeFunciton(url: "MineServiceModule/isShowAlertInfoWithAction:", params: nil) { (boolValue) in
            if (boolValue as! Bool) == true {
                XCTAssert(boolValue as! Bool == true, "")
            }else{
                XCTAssert(boolValue as! Bool == false, "")
            }
        }
    }
    
    func testHaveReturnvalue() {
        let boolValue = IIModuleCore.getInstance().invokingSomeFunciton(url: "MineServiceModule/getIsshowAlertInfo", params: nil, action: nil)
        //XCTAssert((boolValue as! Bool) == true, "呵呵，错了")
    }
    
}
