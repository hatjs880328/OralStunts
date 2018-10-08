//
//  IIGCDUtility.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/23.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

@objc enum IIGCDQos: Int {
    case high
    case veryHigh
    case normal
    case low
}

/// 对GCD进行简单的封装，满足日程需求
class IIGCDUtility: NSObject {
    override init() {
        super.init()
    }

    private static func getRealQOS(with: IIGCDQos) ->DispatchQoS.QoSClass {
        switch with {
        case .veryHigh:
            return DispatchQoS.QoSClass.userInteractive
        case .high:
            return DispatchQoS.QoSClass.userInitiated
        case .normal:
            return DispatchQoS.QoSClass.default
        case .low:
            return DispatchQoS.QoSClass.background
        }
    }

    private static func getRealShortQOS(with: IIGCDQos) -> DispatchQoS {
        switch with {
        case .veryHigh:
            return DispatchQoS.userInteractive
        case .high:
            return DispatchQoS.userInitiated
        case .normal:
            return DispatchQoS.default
        case .low:
            return DispatchQoS.background
        }
    }

    /// 全局线程中异步执行某个方法-,执行完毕回到主线程<主线程异步-防止造成死锁>
    static func async(lvl: IIGCDQos, action:@escaping () -> Void, mainThreadAction: @escaping() -> Void) {
        let qos = getRealQOS(with: lvl)
        DispatchQueue.global(qos: qos).async {
            action()
            DispatchQueue.main.async(execute: {
                mainThreadAction()
            })
        }
    }

    /// 延迟执行，在其他线程中执行
    static func delay(delayTime: Double, lvl: IIGCDQos, action:@escaping () -> Void, mainThreadAction: @escaping() -> Void) {
        DispatchQueue(label: NSUUID().uuidString).after(delayTime) {
            action()
            DispatchQueue.main.async(execute: {
                mainThreadAction()
            })
        }
    }

    /// 线程间通信-线程组
    static func groupAction(lvl: IIGCDQos, mainThreadAction:@escaping () -> Void, otherAction: (() -> Void)...) {
        let qos = getRealQOS(with: lvl)
        let queue = DispatchQueue.global(qos: qos)
        let gcdGroup: DispatchGroup = DispatchGroup()
        let workItem = DispatchWorkItem {
            mainThreadAction()
        }
        gcdGroup.notify(queue: DispatchQueue.main, work: workItem)
        for eachAction in otherAction {
            gcdGroup.enter()
            queue.async {
                eachAction()
                gcdGroup.leave()
            }
        }

    }

    /// 线程间通信-栅栏执行
    static func barrierAction(behiveAction: [() -> Void], barrierAction:@escaping () -> Void, others: [() -> Void], lvl: IIGCDQos) {
        let qos = getRealShortQOS(with: lvl)
        let queue = DispatchQueue(label: NSUUID().uuidString, qos: DispatchQoS.background, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target: nil)

        for eachAction in behiveAction {
            queue.async {
                eachAction()
            }
        }
        queue.async(group: nil, qos: qos, flags: DispatchWorkItemFlags.barrier) {
            barrierAction()
        }

        for eachAction in others {
            queue.async {
                eachAction()
            }
        }
    }

}
