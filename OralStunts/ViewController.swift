//
//  ViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/17.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var lb = UILabel()
    var count = 0
    let vi = OTPlayVw(frame: CGRect(x: 110, y: 110, width: 40, height: 40))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(vi)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.vi.goAni()
    }
}
