//
//  FolderCreateViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/24.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class FolderCreateViewController: IIBaseViewController {
    var nameLb = UITextField()
    
    var confirmBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVw()
        initRx()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initVw() {
        self.title = "文件夹创建"
        self.navigationController?.isNavigationBarHidden = false
        self.view.addSubview(nameLb)
        nameLb.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(25 * APPDelStatic.sizeScale)
            make.height.equalTo(45 * APPDelStatic.sizeScale)
        }
        nameLb.textAlignment = .center
        nameLb.placeholder = "输入文件夹名称"
        nameLb.layer.cornerRadius = 3
        nameLb.layer.borderColor = UIColor.gray.cgColor
        nameLb.layer.borderWidth = 0.5
        nameLb.font = APPDelStatic.uiFont(with: 13)
        // btn
        self.view.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(nameLb.snp.bottom).offset(25 * APPDelStatic.sizeScale)
            make.height.equalTo(45 * APPDelStatic.sizeScale)
        }
        confirmBtn.backgroundColor = APPDelStatic.lightGray
        confirmBtn.layer.cornerRadius = 3
        confirmBtn.layer.borderWidth = 0.5
        confirmBtn.layer.borderColor = UIColor.gray.cgColor
        confirmBtn.titleLabel?.font = APPDelStatic.uiFont(with: 13)
        confirmBtn.setTitle("确定", for: UIControlState.normal)
        confirmBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
    }
    
    func initRx() {
        self.confirmBtn.tapActionsGesture { [weak self] () in
            if self?.nameLb.text == nil || self?.nameLb.text == "" || self == nil  {
                OTAlertVw().alertShowSingleTitle(titleInfo: "提醒", message: "文件夹名称不可为空。")
                return
            }
            let folderIns = OTFolderModel()
            folderIns.title = self!.nameLb.text!
            folderIns.createTime = Date()
            folderIns.contentCount = 0
            FolderBLL().insert(with: folderIns)
            self!.goBack()
        }
    }

}
