//
//  CloudMineTabNormalCell.swift
//  OralStunts
//  个人中心-普通cell
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


class CloudMineTabNormalCell: UITableViewCell {
    
    var headImg: UIImageView!
    
    var userName: UILabel!
    
    let topLine = UIView()
    
    let botLine = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        self.headImg = UIImageView()
        self.userName = UILabel()
        
        //img
        self.addSubview(headImg)
        headImg.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.top.equalTo(10 * APPDelStatic.sizeScale)
            make.height.equalTo(30 * APPDelStatic.sizeScale)
            make.width.equalTo(30 * APPDelStatic.sizeScale)
        }
        headImg.layer.cornerRadius = 15 * APPDelStatic.sizeScale
        headImg.layer.masksToBounds = true
        headImg.layer.masksToBounds = true
        //name
        self.addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(headImg.snp.right).offset(15 * APPDelStatic.sizeScale)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(15 * APPDelStatic.sizeScale)
            make.width.equalTo(200)
        }
        userName.font = APPDelStatic.uiFont(with: 12)
        // top line
        self.addSubview(topLine)
        topLine.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(0.5)
        }
        topLine.backgroundColor = UIColor.gray
        // bottom line
        self.addSubview(botLine)
        botLine.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-0.5)
            make.height.equalTo(0.5)
        }
        botLine.backgroundColor = UIColor.gray
    }
    
    /// 设置下面的线条距离右边一定距离
    func setCustomBotLine() {
        self.botLine.snp.remakeConstraints { (make) in
            make.left.equalTo(45 * APPDelStatic.sizeScale + 18)
            make.right.equalTo(0)
            make.bottom.equalTo(-0.5)
            make.height.equalTo(0.5)
        }
    }
    
    /// 移除上面的线条
    func setCustomTopLine() {
        self.topLine.removeFromSuperview()
    }
    
    func setData(vmodel: (String,String)) {
        self.headImg.image = UIImage(named: vmodel.1)
        self.userName.text = vmodel.0
    }
}
