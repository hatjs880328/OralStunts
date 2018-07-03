//
//  CloudMineTabUserInfoCell.swift
//  OralStunts
//  个人中心-tableview-第一个cell
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


class CloudMineTabUserInfoCell: UITableViewCell {
    
    var headImg: UIImageView!
    
    var userName: UILabel!
    
    var companyName: UILabel!
    
    var picWin : UIWindow!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // height
    func createVw() {
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        self.headImg = UIImageView()
        self.userName = UILabel()
        self.companyName = UILabel()
        
        //img
        self.addSubview(headImg)
        headImg.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.top.equalTo(15 * APPDelStatic.sizeScale)
            make.height.equalTo(70 * APPDelStatic.sizeScale)
            make.width.equalTo(70 * APPDelStatic.sizeScale)
        }
        headImg.layer.cornerRadius = 35 * APPDelStatic.sizeScale
        headImg.layer.masksToBounds = true
        headImg.tapActionsGesture { [weak self]() in
            self?.showBigImg()
        }
        //name
        self.addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(headImg.snp.right).offset(15 * APPDelStatic.sizeScale)
            make.bottom.equalTo(self.snp.centerY).offset(-5 * APPDelStatic.sizeScale)
            make.height.equalTo(15 * APPDelStatic.sizeScale)
            make.width.equalTo(200)
        }
        userName.font = APPDelStatic.uiFont(with: 15)
        //companyname
        self.addSubview(companyName)
        companyName.snp.makeConstraints { (make) in
            make.left.equalTo(headImg.snp.right).offset(15 * APPDelStatic.sizeScale)
            make.top.equalTo(self.snp.centerY).offset(5 * APPDelStatic.sizeScale)
            make.height.equalTo(13 * APPDelStatic.sizeScale)
            make.width.equalTo(200)
        }
        companyName.font = APPDelStatic.uiFont(with: 11)
        companyName.textColor = APPDelStatic.themeColor
        // top line
        let topLine = UIView()
        self.addSubview(topLine)
        topLine.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(0.5)
        }
        topLine.backgroundColor = UIColor.gray
        // bottom line
        let botLine = UIView()
        self.addSubview(botLine)
        botLine.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-0.5)
            make.height.equalTo(0.5)
        }
        botLine.backgroundColor = UIColor.gray
    }
    
    /// 赋值方法
    func setData(vmodel: CloudMineTabVwCellModel) {
        self.headImg.sd_setImage(with: vmodel.imageUrl, placeholderImage: UIImage(named: vmodel.imagePlaceHolder), options: SDWebImageOptions.allowInvalidSSLCertificates, completed: nil)
        self.userName.text = vmodel.name
        self.companyName.text = vmodel.companyName
    }
    
    /// 显示大图
    func showBigImg() {
        if let tabVw = self.superview?.superview as? CloudMineTabVw {
            picWin = CloudMinePicShow(frame: self.window!.frame, imageUrl: tabVw.tabVM.userInfoVmodel.imageUrl)
        }
    }
}
