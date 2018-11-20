//
//  MineBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class MineBLL: NSObject {

    func getUserInfo() -> OTUserInfo {
        return MineDAL().getUserInfo()
    }

    func insertUserInto(with: OTUserInfo) {
        print(with.id)
        MineDAL().insertOneInfo(with: with)
    }

    func updateGender(gender: String) {
        MineDAL().updateGender(gender: gender)
    }

    func updateNote(note: String) {
        MineDAL().updateNote(note: note)
    }

    func updateAlertInfo(alert: Bool) {
        MineDAL().updateAlertInfo(note: alert)
    }

}
