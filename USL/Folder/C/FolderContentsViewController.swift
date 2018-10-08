//
//  FolderContentsViewController.swift
//  OralStunts
//  文件夹点击进入，查看当前文件夹下面所有note的vc
//  Created by Noah_Shan on 2018/5/28.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class FolderContentsViewController: IIBaseViewController {

    var tab: SearchVCTabVw!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(NoteCreatingBLL.getInstance().showingFolderMoel.title)"
        self.navigationController?.isNavigationBarHidden = false
        //暂时关闭
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "全选", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.selectAllItem))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_ animated: Bool) {
        initVw()
        self.getData()
    }

    func initVw() {
        if tab != nil { return }
        let emptyVw = UIView()
        self.view.addSubview(emptyVw)
        emptyVw.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(0)
        }
        tab = SearchVCTabVw(frame: CGRect.zero, fatherVw: self.view, topVw: emptyVw)
    }

    func getData() {
        self.tab.vm.loadData(with: NoteCreatingBLL.getInstance().showingFolderMoel.id)
    }

    @objc func selectAllItem() {
        let showStr = self.tab.vm.selectAllOrNot()
        self.navigationItem.rightBarButtonItem?.title = showStr
    }

}
