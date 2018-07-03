//
//  FolderViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/23.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class FolderViewController: IIBaseViewController {

    var searchVw: OTSearchVw!
    var tabVw: FolderTabVw!
    override func viewDidLoad() {
        super.viewDidLoad()
        createVw()
        createAction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabVw.getData()
    }
    
    func createVw() {
        self.navigationController?.isNavigationBarHidden = true
        let topVw: TopLeftTitleVw = TopLeftTitleVw(frame: CGRect.zero, fatherVw: self.view, txt: "便签")
        // +号vw
        let _ = AddRightVw(frame: CGRect.zero, fatherVw: self.view)
        // 搜索vw
        searchVw = OTSearchVw(frame: CGRect.zero, fatherVw: self.view, topVw: topVw, jumpOrUse: true)
        // content tab vw
        tabVw = FolderTabVw(frame: CGRect.zero, fatherVw: self.view, topVw: searchVw)
    }
    
    func createAction() {
        self.tabVw.cellDidSelect = { [weak self]folderCellVModelInfo in
            let con = FolderContentsViewController()
            NoteCreatingBLL.getInstance().showingFolderMoel = folderCellVModelInfo.sourceNote
            con.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(con, animated: true)
        }
    }
}
