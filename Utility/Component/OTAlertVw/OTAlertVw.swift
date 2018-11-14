//
//  OTAlertVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import SCLAlertView

@objc class OTAlertVw: NSObject {

    override init() {
        super.init()
    }

    /// 单行文档提示
    func alertShowSingleTitle(titleInfo: String, message: String) {
        let toast = FFToast(toastWithTitle: titleInfo, message: message, iconImage: UIImage(name: "fftoast_info"))
        toast?.toastPosition = .belowStatusBarWithFillet
        toast?.duration = 1.8
        toast?.toastBackgroundColor = APPDelStatic.themeColor
        toast?.show()
    }
    /// 两个按钮的提示
    func alertShowConfirm(title: String, message: String, confirmStr: String, confirmAction:@escaping () -> Void) {

        let alertVw = SCLAlertView()
        alertVw.addButton(confirmStr) {
            confirmAction()
        }
        alertVw.showWarning(title, subTitle: message, closeButtonTitle: "取消", timeout: nil, colorStyle: 0x006569, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.topToBottom)

    }

    @objc func alertShowCreateNoteAndFolderVw() {
        if let nowCon = ((UIApplication.shared.keyWindow!.rootViewController as! SaltedFishTabBarVC).selectedViewController as! UINavigationController).viewControllers.last {
            let alertVw = SCLAlertView()
            alertVw.addButton("便签") {
                let con = NoteContextCreateViewController()
                NoteCreatingBLL.getInstance().progressModelTitle(title: NoteCreatingBLL.getInstance().creatingNoteModel.id, volumeList: [])
                con.hidesBottomBarWhenPushed = true
                con.presentedVcHasNavigation = false
                nowCon.navigationController?.pushViewController(con, animated: true)
            }
            alertVw.addButton("文件夹") {
                let con = FolderCreateViewController()
                con.hidesBottomBarWhenPushed = true
                con.presentedVcHasNavigation = false
                nowCon.navigationController?.pushViewController(con, animated: true)
            }
            alertVw.showEdit("选择新建项目", subTitle: "", closeButtonTitle: "取消", timeout: nil, colorStyle: 0x006569, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.topToBottom)
        }

    }
}
