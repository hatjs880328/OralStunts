//
//  MoveNote2FolderViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/25.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

/// 移动便签到文件夹的页面
class MoveNote2FolderViewController: IIBaseViewController {

    var tabVw: FolderTabVw!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择文件夹"
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createVw()
        self.tabVw.getData()
    }
    
    func createVw() {
        if self.tabVw != nil { return }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.progressOver))
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: APPDelStatic.themeColor]
        // content tab vw
        tabVw = FolderTabVw(frame: CGRect.zero, fatherVw: self.view, topVw: nil,haveCheckBox:true)
    }
    
    @objc func progressOver() {
        
        NoteLogicBLL().moveNote2Folder(folderID: self.tabVw.vm.selectedCellIDS.keys.first){ [weak self] (isFail) in
            if isFail {
                OTAlertVw().alertShowSingleTitle(titleInfo: "提醒", message: "请选择一个目标文件夹！", from: self!)
            }else{
                self?.goBack()
            }
        }
    }

}
