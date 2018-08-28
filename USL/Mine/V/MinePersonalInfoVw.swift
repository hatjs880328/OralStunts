//
//  MinePersonalInfoVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/24.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


class MinePersonalInfoVw: UIView {
    
    let nameLb: UILabel = UILabel()
    
    let img: UIImageView = UIImageView()
    
    let noteLb: UILabel = UILabel()
    
    let vm = MinePersonalInfoVM()
    
    init(frame: CGRect,fatherVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(APPDelStatic.noNaviTopDistance + 20 * APPDelStatic.sizeScale)
            make.height.equalTo(155 * APPDelStatic.sizeScale)
        }
        initVw()
        setData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initVw() {
        //bgvw
        let bgVw = UIView()
        self.addSubview(bgVw)
        bgVw.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        bgVw.layer.cornerRadius = 3
        bgVw.layer.borderColor = UIColor.gray.cgColor
        bgVw.layer.borderWidth = 0.5
        // name
        self.addSubview(nameLb)
        nameLb.snp.makeConstraints { (make) in
            make.left.equalTo(10 * APPDelStatic.sizeScale)
            make.right.equalTo(-10)
            make.top.equalTo(10 * APPDelStatic.sizeScale)
            make.height.equalTo(22 * APPDelStatic.sizeScale)
        }
        nameLb.font = APPDelStatic.uiFont(with: 20)
        nameLb.textColor = APPDelStatic.themeColor
        // person img
        self.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.right.equalTo(-10 * APPDelStatic.sizeScale)
            make.width.equalTo(80 * APPDelStatic.sizeScale)
            make.top.equalTo(10 * APPDelStatic.sizeScale)
            make.height.equalTo(80 * APPDelStatic.sizeScale)
        }
        img.layer.cornerRadius = 80 * APPDelStatic.sizeScale / 2
        img.backgroundColor = APPDelStatic.lightGray
        img.image = UIImage(named: "boy.png")
        img.tapActionsGesture {[weak self]() in
            //点击更换头像
            self?.changePic()
        }
        img.backgroundColor = APPDelStatic.themeColor
        img.layer.masksToBounds = true
        // line
        let line = UIView()
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(15 * APPDelStatic.sizeScale)
            make.right.equalTo(0)
            make.top.equalTo(img.snp.bottom).offset(15 * APPDelStatic.sizeScale)
            make.height.equalTo(1)
        }
        line.backgroundColor = APPDelStatic.lightGray
        // note img
        let noteImg = UIImageView()
        self.addSubview(noteImg)
        noteImg.snp.makeConstraints { (make) in
            make.left.equalTo(10 * APPDelStatic.sizeScale)
            make.width.equalTo(20 * APPDelStatic.sizeScale)
            make.bottom.equalTo(-10 * APPDelStatic.sizeScale)
            make.height.equalTo(20 * APPDelStatic.sizeScale)
        }
        noteImg.image = UIImage(named: "noteInfo.png")
        // note
        self.addSubview(noteLb)
        noteLb.snp.makeConstraints { (make) in
            make.left.equalTo(noteImg.snp.right).offset(10 * APPDelStatic.sizeScale)
            make.right.equalTo(0)
            make.centerY.equalTo(noteImg.snp.centerY)
            make.height.equalTo(12 * APPDelStatic.sizeScale)
        }
        noteLb.font = APPDelStatic.uiFont(with: 12)
    }
    
    func setData() {
        self.nameLb.text = MineBLL().getUserInfo().nickName
        self.noteLb.text = MineBLL().getUserInfo().noteInfo
        self.img.image = UIImage(named: self.vm.getHeadImg())
    }
    
    func changePic() {
        let imgName = self.vm.updateHeadImg()
        self.img.image = UIImage(named: imgName)
    }
}
