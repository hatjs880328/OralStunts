//
//  EvernoteViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/8/31.
//  Copyright © 2018 Inspur. All rights reserved.
//

import UIKit

class EvernoteViewController: IIBaseViewController {

    let evernote = Evernote()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        evernote.setupKey()
        evernote.authenticationSetup(delegate: self)
    }

}
