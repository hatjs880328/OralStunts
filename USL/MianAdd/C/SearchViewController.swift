//
//  SearchViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class SearchViewController: IIBaseViewController {

    var tabVw: SearchVCTabVw!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "搜搜"
        createVw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createVw() {
        let searchVw = OTSearchVw(frame: CGRect.zero, fatherVw: self.view, topVw: nil,jumpOrUse:false)
        searchVw.remakeCon(right: 45 * APPDelStatic.sizeScale)
        let cancelBtn = UIButton()
        self.view.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-18)
            make.centerY.equalTo(searchVw.snp.centerY)
            make.width.equalTo(40 * APPDelStatic.sizeScale)
            make.height.equalTo(15 * APPDelStatic.sizeScale)
        }
        cancelBtn.setTitle("取消", for: UIControlState.normal)
        cancelBtn.tapActionsGesture { [weak self] () in
            self?.navigationController?.popViewController(animated: true)
        }
        cancelBtn.titleLabel?.font = APPDelStatic.uiFont(with: 13)
        cancelBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        // tab
        tabVw = SearchVCTabVw(frame: CGRect.zero, fatherVw: self.view, topVw: searchVw)
    }
    
    deinit {
        print("搜索页面释放")
    }

}
