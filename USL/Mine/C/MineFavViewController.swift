//
//  MineFavViewController.swift
//  OralStunts
//  我喜欢列表
//  Created by Noah_Shan on 2018/5/28.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class MineFavViewController: IIBaseViewController {
    
    var tab: SearchVCTabVw!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我喜欢的"
        self.navigationController?.isNavigationBarHidden = false
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
        self.tab.vm.loadFavData()
    }
    
    @objc func selectAllItem() {
        let showStr = self.tab.vm.selectAllOrNot()
        self.navigationItem.rightBarButtonItem?.title = showStr
    }
    
}
