//
//  SearchVCTabCell.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/21.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class SearchVCTabCell: UITableViewCell {
    
    var titleLB:UILabel = UILabel()
    var abstractLB: UILabel = UILabel()
    var modifyTimeLb:UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.addSubview(titleLB)
        self.addSubview(abstractLB)
        self.addSubview(modifyTimeLb)
        // title
        titleLB.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(10 * APPDelStatic.sizeScale)
            make.height.equalTo(18 * APPDelStatic.sizeScale)
        }
        titleLB.font = APPDelStatic.uiFont(with: 15)
        // abstract lb
        abstractLB.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(titleLB.snp.bottom).offset(10 * APPDelStatic.sizeScale)
            make.height.equalTo(30 * APPDelStatic.sizeScale)
        }
        abstractLB.numberOfLines = 0
        abstractLB.font = APPDelStatic.uiFont(with: 11)
        abstractLB.textColor = UIColor.gray
        // modifytime
        modifyTimeLb.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(abstractLB.snp.bottom).offset(10 * APPDelStatic.sizeScale)
            make.height.equalTo(12 * APPDelStatic.sizeScale)
        }
        modifyTimeLb.font = APPDelStatic.uiFont(with: 11)
        modifyTimeLb.textColor = UIColor.gray
        // line
        let botLine = UIView()
        self.addSubview(botLine)
        botLine.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(99.5 * APPDelStatic.sizeScale, 18, 0, 0))
        }
        botLine.backgroundColor = UIColor.gray
    }
    
    func setData(model: SearchvcVmodel,isSelectAll: Bool = false) {
        self.titleLB.text = model.title
        self.abstractLB.text = model.abstract
        self.modifyTimeLb.text = model.modifyTime
        if isSelectAll {
            self.titleLB.textColor = APPDelStatic.themeColor
        }else {
            self.titleLB.textColor = UIColor.black
        }
    }
}
