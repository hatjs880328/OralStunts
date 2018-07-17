//
//  MineAboutUsBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/19.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation


class MineAboutUsBLL: NSObject {
    
    func changeColor() ->UIColor {
        let color = [APPDelStatic.themeColor,UIColor.black,UIColor.gray,APPDelStatic.lightGray]
        let randomIntvalue = Int(arc4random() % 4)//0//Int.random(in: Range(uncheckedBounds: (lower: 0, upper: 3)))
        return color[randomIntvalue]
    }
}
