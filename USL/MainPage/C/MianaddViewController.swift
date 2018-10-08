//
//  MianaddViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class MianaddViewController: IIBaseViewController {

    var tabVw: MainVCTabVw!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        createVw()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        self.tabVw.leftVwloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func createVw() {
        let topVw = TopHelloVw(frame: CGRect.zero, fatherVw: self.view)
        //let searchVw = OTSearchVw(frame: CGRect.zero, fatherVw: self.view, topVw: topVw)
        tabVw = MainVCTabVw(frame: CGRect.zero, fatherVw: self.view, topVw: topVw)
    }

}
