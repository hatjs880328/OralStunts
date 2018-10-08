//
//  MineAboutUsBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/19.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

class MineAboutUsBLL: NSObject {

    func changeColor() -> UIColor {
        let color = [APPDelStatic.themeColor, UIColor.black, UIColor.gray]
        let randomIntvalue = Int(arc4random() % 3)
        return color[randomIntvalue]
    }
}
