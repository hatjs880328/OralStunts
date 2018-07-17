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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(lb)
        lb.frame = self.view.frame
        lb.text = "--"
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.count += 1
                self.lb.text = "\(self.count)秒"
            }
        } else {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let con = LoginInViewController()
        self.navigationController?.pushViewController(con, animated: true)
        
//        IIGCDUtility.async(lvl: IIGCDQos.low, action: {
//            for eachitem in 0 ... 1000000000000 {
//                for eachItem in 0 ... 1000000000000 {
//                    //print("low thread progress\(eachitem) - \(eachItem)")
//                    var a = eachitem + eachItem
//                }
//            }
//        }) {
//            
//        }
//        
//        ///数据库操作
//        IIGCDUtility.async(lvl: IIGCDQos.low, action: {
//            for eachitem in 0 ... 1000000000000 {
//                for eachItem in 0 ... 1000000000000 {
//                    //NoteCreatingBLL.getInstance().insertModel()
//                    var model = OTNoteModel()
//                    
//                    NoteLogicBLL().insertNoteInfo(with: model)
//                    print("22")
//                }
//            }
//        }) {
//            
//        }
        
    }


}

