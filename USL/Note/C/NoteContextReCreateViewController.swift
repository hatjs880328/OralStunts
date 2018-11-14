//
//  NoteContextReCreateViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/25.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

/// 修改-note页面
class NoteContextReCreateViewController: IIBaseViewController {

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
        self.title = SearchvcVmodel().setData(model: NoteCreatingBLL.getInstance().showingNoteModel).abstract
        self.navigationController?.isNavigationBarHidden = false
        let lastedVw = LstaedEditedInfoVw(frame: CGRect.zero, fatherVw: self.view)
        self.contextVw = ContextInsertVw(frame: CGRect.zero, fatherVw: self.view, topVw: lastedVw)
        self.voiceVw = VoiceBtnVw(frame: CGRect.zero, fatherVw: self.view, warningTxt: WhichStepCreatingNote.reContent.rawValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func postSignal() {
        self.contextVw.postRecreateSignal()
    }

}
