//
//  NoteTimeLineViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/24.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class NoteTimeLineViewController: IIBaseViewController {

    var menuListVw: OTTablistVw!
    
    var timeVw: NoteTimerLineVw!
    
    var shelterVw: ShelterVw!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NoteCreatingBLL.getInstance().showingNoteModel.title
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Category.png"), style: UIBarButtonItemStyle.done, target: self, action: #selector(self.showOrHiddenMenu))
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: APPDelStatic.themeColor]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initVw()
        createAction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initVw() {
        self.timeVw = NoteTimerLineVw(frame: CGRect.zero, fatherVw: self.view)
        self.shelterVw = ShelterVw(frame: CGRect.zero, fatherVw: self.view)
        self.menuListVw = OTTablistVw(frame: CGRect.zero, fatherVw: self.view)
    }
    
    func createAction() {
        let actionEdit = { [weak self]() in
            let con = NoteContextReCreateViewController()
            con.presentedVcHasNavigation = true
            self?.navigationController?.pushViewController(con, animated: true)
            self?.showOrHiddenMenu()
        }
        let actionMove = { [weak self]() in
            let con = MoveNote2FolderViewController()
            con.shouldMoveID = [NoteCreatingBLL.getInstance().showingNoteModel.id]
            con.presentedVcHasNavigation = true
            self?.navigationController?.pushViewController(con, animated: true)
            self?.showOrHiddenMenu()
        }
        let actionDel = { [weak self]() in
            if self == nil { return }
            OTAlertVw().alertShowConfirm(title: "提醒", message: "确认要删除当前便签吗？",confirmStr: "删除", confirmAction: { () in
                NoteLogicBLL().deleateOneNote(with: NoteCreatingBLL.getInstance().showingNoteModel.id)
                self?.navigationController?.popToRootViewController(animated: true)
            })
        }
        let shareAction = { [weak self]() in
            if self == nil { return }
            OTShare.share(with: self!.view, title: NoteCreatingBLL.getInstance().showingNoteModel.title, subTitle: NoteCreatingBLL.getInstance().showingNoteModel.contentTxt.last!, img: "voice.png", shareUrl: URL(string: "http://www.baidu.com")!)
            self?.showOrHiddenMenu()
        }
        self.menuListVw.didSelectAction.append(actionEdit)
        self.menuListVw.didSelectAction.append(actionMove)
        self.menuListVw.didSelectAction.append(actionDel)
        self.menuListVw.didSelectAction.append(shareAction)
        self.shelterVw.tapAction = { [weak self]() in
            self?.showOrHiddenMenu()
        }
    }
    
    @objc func showOrHiddenMenu() {
        if self.menuListVw.alpha == 0 {
            self.menuListVw.alpha = 1
            self.shelterVw.showSelf()
        }else{
            self.menuListVw.alpha = 0
            self.shelterVw.hiddenSelf()
        }
    }
}
