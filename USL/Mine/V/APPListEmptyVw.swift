//
//  APPListEmptyVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/17.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

class APPListEmptyVw: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        let note = UILabel()
        note.numberOfLines = 0
        self.addSubview(note)
        note.snp.makeConstraints { (make) in
            make.left.equalTo(10 * APPDelStatic.sizeScale)
            make.right.equalTo(-10 * APPDelStatic.sizeScale)
            make.top.equalTo(15 * APPDelStatic.sizeScale)
            make.bottom.equalTo(-30 * APPDelStatic.sizeScale)
        }
        note.layer.cornerRadius = 4
        note.layer.borderColor = APPDelStatic.themeColor.cgColor
        note.layer.borderWidth = 0.5
        note.textAlignment = .center
        note.textColor = UIColor.gray
        note.font = APPDelStatic.uiFont(with: 12)
    }
}
