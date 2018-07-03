//
//  NoteContextCreateViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/22.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class NoteContextCreateViewController: IIBaseViewController {

    var contextVw: ContextInsertVw!
    var voiceVw: VoiceBtnVw!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBar()
        createVw()
    }
    
    func createBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.postSignal))
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: APPDelStatic.themeColor]
    }
    
    func createVw() {
        self.title = "Note正文录入"
        self.navigationController?.isNavigationBarHidden = false
        self.contextVw = ContextInsertVw(frame: CGRect.zero, fatherVw: self.view)
        self.voiceVw = VoiceBtnVw(frame: CGRect.zero, fatherVw: self.view,warningTxt:WhichStepCreatingNote.content.rawValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func goMainPage() {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func postSignal() {
        self.contextVw.postDoneSignal()
    }

}
