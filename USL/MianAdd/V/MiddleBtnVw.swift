//
//  MiddleBtnVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/19.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class MiddleBtnVw: UIView {
    var createBtn:UIButton = UIButton()
    var floderBtn: UIButton = UIButton()
    init(frame: CGRect,fatherVw:UIView,topVw:UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.bottom.equalTo(0)
            make.top.equalTo(topVw.snp.bottom).offset(10 * APPDelStatic.sizeScale)
        }
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.addSubview(createBtn)
        self.addSubview(floderBtn)
        // note container
        let noteContainer = UIView()
        self.addSubview(noteContainer)
        noteContainer.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(45 * APPDelStatic.sizeScale)
        }
        noteContainer.layer.borderWidth = 0.5
        noteContainer.layer.borderColor = UIColor.gray.cgColor
        noteContainer.layer.cornerRadius = 4
        // note img
        let noteImg = UIImageView()
        noteImg.image = UIImage(named: "createNote.png")
        self.addSubview(noteImg)
        //note
        createBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(200)
            make.top.equalTo(0)
            make.height.equalTo(45 * APPDelStatic.sizeScale)
        }
        createBtn.setTitle("创建便签", for: UIControlState.normal)
        createBtn.titleLabel?.font = APPDelStatic.uiFont(with: 12)
        createBtn.setTitleColor(.black, for: UIControlState.normal)
        noteContainer.tapActionsGesture {
            let con = NoteCreateViewController()
            con.hidesBottomBarWhenPushed = true
            con.presentedVcHasNavigation = false
            self.viewController()?.navigationController?.pushViewController(con, animated: true)
        }
        noteImg.snp.makeConstraints { (make) in
            make.left.equalTo(20 * APPDelStatic.sizeScale)
            make.width.equalTo(25 * APPDelStatic.sizeScale)
            make.centerY.equalTo(createBtn.snp.centerY)
            make.height.equalTo(25 * APPDelStatic.sizeScale)
        }
        // folder container
        let folderContainer = UIView()
        self.addSubview(folderContainer)
        folderContainer.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(createBtn.snp.bottom).offset(20 * APPDelStatic.sizeScale)
            make.height.equalTo(45 * APPDelStatic.sizeScale)
        }
        folderContainer.layer.borderWidth = 0.5
        folderContainer.layer.borderColor = UIColor.gray.cgColor
        folderContainer.layer.cornerRadius = 4
        // folder img
        let folderImg = UIImageView()
        folderImg.image = UIImage(named: "FolderCell.png")
        self.addSubview(folderImg)
        // flolder
        floderBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(200)
            make.top.equalTo(createBtn.snp.bottom).offset(20 * APPDelStatic.sizeScale)
            make.height.equalTo(45 * APPDelStatic.sizeScale)
        }
        floderBtn.setTitle("创建文件夹", for: UIControlState.normal)
        floderBtn.titleLabel?.font = APPDelStatic.uiFont(with: 12)
        floderBtn.setTitleColor(.black, for: UIControlState.normal)
        folderImg.snp.makeConstraints { (make) in
            make.left.equalTo(20 * APPDelStatic.sizeScale)
            make.width.equalTo(25 * APPDelStatic.sizeScale)
            make.centerY.equalTo(floderBtn.snp.centerY)
            make.height.equalTo(25 * APPDelStatic.sizeScale)
        }
        folderContainer.tapActionsGesture {
            let con = FolderCreateViewController()
            con.hidesBottomBarWhenPushed = true
            con.presentedVcHasNavigation = false
            self.viewController()?.navigationController?.pushViewController(con, animated: true)
        }
    }
}
