//
//  IIBaseViewController.swift
//  DingTalkCalendar
//
//  Created by Noah_Shan on 2018/5/11.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

/*
 TODO:
 1.NET WORK OBSERVER   [use realReachability  & ping function]
 2.CSAN NET WORK
 3.KEY BOARD AND OTHERS OBSERVER
 4.BACKGROUND & FOREGROUND OBSERVER
 */

class IIBaseViewController: UIViewController {

    var presentedVcHasNavigation:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back.png"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.goBack))
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: APPDelStatic.themeColor]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc dynamic func goBack() {
        let beforeVC = getBeforeVC()
        if self.presentedVcHasNavigation {
            beforeVC?.navigationController?.isNavigationBarHidden = false
        }else{
            beforeVC?.navigationController?.isNavigationBarHidden = true
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func getBeforeVC()->UIViewController? {
        for i in 0 ..< self.navigationController!.viewControllers.count {
            if self.navigationController!.viewControllers[i] === self {
                return self.navigationController!.viewControllers[i - 1]
            }else{
                continue
            }
        }
        return nil
    }

}
