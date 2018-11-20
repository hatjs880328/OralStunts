//
//  NoteContextCreateViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/22.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import UIKit
import IntentsUI
import Intents
import CoreSpotlight

class NoteContextCreateViewController: IIBaseViewController,INUIAddVoiceShortcutViewControllerDelegate {

    var contextVw: ContextInsertVw!
    var voiceVw: VoiceBtnVw!

    override func viewDidLoad() {
        super.viewDidLoad()
        createBar()
        createVw()
    }

    func createBar() {
        let rightOne = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.postSignal))
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: APPDelStatic.themeColor]
        let rightTwo = UIBarButtonItem(image: UIImage(named: "note_create_righticon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.addSiri))
        self.navigationItem.rightBarButtonItems = [rightTwo,rightOne]
    }

    func createVw() {
        self.title = "Note正文录入"
        self.navigationController?.isNavigationBarHidden = false
        self.contextVw = ContextInsertVw(frame: CGRect.zero, fatherVw: self.view)
        self.voiceVw = VoiceBtnVw(frame: CGRect.zero, fatherVw: self.view, warningTxt: WhichStepCreatingNote.content.rawValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func goMainPage() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.popToRootViewController(animated: true)
    }

    @objc func postSignal() {
        self.contextVw.postDoneSignal()
    }

    @objc func addSiri() {
        if #available(iOS 12.0, *) {
            let activity = OTSiri.videoDing(vi: self.view)
            let short = INShortcut(userActivity: activity)
            let con = INUIAddVoiceShortcutViewController(shortcut: short)
            con.delegate = self
            self.present(con, animated: true, completion: nil)
        } else {
            OTAlertVw().alertShowSingleTitle(titleInfo: "提醒", message: "Siri功能需要iOS12+系统支持")
        }
    }

    @available(iOS 12.0, *)
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    @available(iOS 12.0, *)
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

}
