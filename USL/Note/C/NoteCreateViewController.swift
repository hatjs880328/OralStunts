//
//  NoteCreateViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/21.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import UIKit
import IntentsUI
import Intents
import CoreSpotlight

class NoteCreateViewController: IIBaseViewController, INUIAddVoiceShortcutViewControllerDelegate {

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
        self.voiceVw = VoiceBtnVw(frame: CGRect.zero, fatherVw: self.view, warningTxt: WhichStepCreatingNote.title.rawValue)
        //
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "note_create_righticon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.addSiri))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

    deinit {
        print("创建正文页面销毁")
    }

}
