//
//  IIGCGTest.swift
//  OralStuntsTests
//
//  Created by Noah_Shan on 2018/6/23.
//  Copyright © 2018 Inspur. All rights reserved.
//

import XCTest
@testable import OralStunts

class IIGCGTest: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testBarrier() {
        var b: [()->Void] = []
        var bb: [()->Void] = []
        for eachItem in 0 ... 7 {
            let action: ()->Void = { () in
                for eachI in 0 ... 4 {
                    print("\(eachItem)ddddd")
                }
            }
            if eachItem < 4 {
                b.append(action)
            }else{
                bb.append(action)
            }
        }
        
        let barrier = {
            for eachItem in 0 ... 3 {
                print("barrier")
            }
        }
        
        IIGCDUtility.barrierAction(behiveAction: b,barrierAction:barrier,others: bb,lvl: IIGCDQos.veryHigh)
    }
    
    func testGroup() {
        let action: ()->Void = { () in
            for eachI in 0 ... 4 {
                print("ddddd")
            }
        }
        
        IIGCDUtility.groupAction(lvl: IIGCDQos.high, mainThreadAction: {
            print("回到主线程了执行。")
        },otherAction: {
            print("dfa")
        },{
            print("dfa1")
        },{
            print("dfa2")
        })
    }

}
