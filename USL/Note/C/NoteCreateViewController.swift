//
//  NoteCreateViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/21.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class NoteCreateViewController: IIBaseViewController {

    var titleVw: TitleInsertVw!
    var voiceVw: VoiceBtnVw!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createVw()
    }
    
    func createVw() {
        self.title = "Note创建"
        self.navigationController?.isNavigationBarHidden = false
        self.titleVw = TitleInsertVw(frame: CGRect.zero, fatherVw: self.view)
        self.voiceVw = VoiceBtnVw(frame: CGRect.zero, fatherVw: self.view,warningTxt:WhichStepCreatingNote.title.rawValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("创建正文页面销毁")
    }

}
