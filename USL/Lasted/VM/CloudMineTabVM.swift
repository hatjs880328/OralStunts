//
//  CloudMineTabVM.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

// 第一个cell的vmodel
class CloudMineTabVwCellModel: NSObject {
    
    var name = ""
    
    var companyName = ""
    
    var imageUrl:URL?
    
    var imagePlaceHolder = ""
    
    init(with model: CloudMineModel) {
        self.companyName = model.companyName
        self.imagePlaceHolder = model.imagePlaceHolder
        self.imageUrl = URL(string: model.imageUrl)
        self.name = model.name
    }
    
}

class CloudMineTabVM : IIBaseVM {
    
    var userInfoVmodel: CloudMineTabVwCellModel! {
        didSet{
            if self.userInfoChangeAction == nil { return }
            self.userInfoChangeAction()
        }
    }
    
    let tabDatasource = [[("系统设置","useHelp.png")],[("意见反馈","vedioPlay.png"),("云＋客服","createNote.png")],[("关于我们","noteInfo.png")]]
    
    var userInfoChangeAction: (()->Void)!
    
    let resueID = "CloudMineTabVwCellReuseID"
    
    override init() {
        super.init()
    }
    
    /// 获取用户数据
    func getUserInfo() {
        self.userInfoVmodel = CloudMineBLL().getDBData()
    }
    
    /// 获取section个数
    func getSectionNumber() ->Int {
        return self.tabDatasource.count + 1
    }
    
    /// cell行数
    func getCellRows(section:Int)-> Int {
        if section == 0 { return 1 }
        return self.tabDatasource[section - 1].count
    }
    
    /// 跳转到的vc
    func didSelectVC(with index:IndexPath)->UIViewController? {
        switch index.section {
        case 0:
            let con = MineAboutUSViewController()
            con.presentedVcHasNavigation = true
            return con
        case 1:
            let con = MineAboutUSViewController()
            con.presentedVcHasNavigation = true
            return con
        case 2:
            let con = MineAboutUSViewController()
            con.presentedVcHasNavigation = true
            return con
        case 3:
            let con = MineAboutUSViewController()
            con.presentedVcHasNavigation = true
            return con
        default:
            return nil
        }
    }
    
    /// 获取高度
    func rowsHeight(with index:IndexPath) ->CGFloat {
        if index.section == 0 {
            return 100 * APPDelStatic.sizeScale
        }
        return 50 * APPDelStatic.sizeScale
    }
    
    /// 获取cell
    func getCell(with index: IndexPath) ->UITableViewCell {
        if index.section == 0 {
            let firstCell = CloudMineTabUserInfoCell(style: UITableViewCellStyle.default, reuseIdentifier: resueID)
            if self.userInfoVmodel != nil {
                firstCell.setData(vmodel: userInfoVmodel!)
            }
            return firstCell
        }
        let normalModel = self.tabDatasource[index.section - 1][index.row]
        let cell = CloudMineTabNormalCell(style: UITableViewCellStyle.default, reuseIdentifier: resueID)
        if index.section == 2 && index.row == 0 {
            cell.setCustomBotLine()
        }
        if index.section == 2 && index.row == 1 {
            cell.setCustomTopLine()
        }
        cell.setData(vmodel: normalModel)
        return cell
    }
    
}
