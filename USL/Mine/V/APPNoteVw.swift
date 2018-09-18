//
//  APPNoteVw.swift
//  OralStunts
//  当app内的tableview页面为空时，显示这个说明view
//  Created by Noah_Shan on 2018/6/4.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class APPNoteVw: UIView {
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
        note.text = """
        Note|使用帮助
        
        ---关于最新---
        当你创建一个便签时，它不会自动放到某一个文件夹下面
        ，可直接在列表中左滑、移动到某个文件夹下
        
        ---关于新建便签---
        标题、详情都可以使用语音创建，在联网情况下可自动识
        别语音文字，如果没有网络则只会保存语音文件，但文本
        不可为空（可手动添加一些文字）
        
        ---关于头像、动态、我喜欢功能---
        支持系统预制的头像图片；动态功能暂不开放
        
        ---关于日历功能---
        日历集成了当天创建的便签的功能，方便用户按照日期查
        找、查看便签
        
        ---最后---
        希望您能给我们改进的宝贵意见
        """
        note.textAlignment = .center
        note.textColor = UIColor.gray
        note.font = APPDelStatic.uiFont(with: 12)
    }
}
