//
//  BaseTabbar.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


class BaseTabbar: UITabBarController,UITabBarControllerDelegate {
    //最新
    let newest = UINavigationController(rootViewController: WorkBenchViewControllerV2())
    //文件夹
    let folder = UINavigationController(rootViewController: FolderViewController())
    //添加
    let addding = UINavigationController(rootViewController: MianaddViewController())
    //我的
    var myInfo = UINavigationController(rootViewController: MineViewController())
    
    var badgeView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //全局设置
        self.tabBar.backgroundImage = UIColor.clear.toImage()
        self.tabBar.shadowImage = UIColor.clear.toImage()
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.tintColor = APPDelStatic.themeColor
        self.tabBar.isTranslucent = false
        // 最新
        newest.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        newest.tabBarItem.title = "日历"
        newest.edgesForExtendedLayout = .top
        newest.navigationBar.shadowImage = APPDelStatic.themeColor.toImage()
        newest.tabBarItem.image = UIImage(named: "newDeselected")
        newest.tabBarItem.selectedImage = UIImage(named: "newSelected")
        newest.navigationBar.tintColor = APPDelStatic.themeColor
        newest.navigationBar.isTranslucent = false
        newest.navigationBar.setBackgroundImage(UIColor.white.toImage(), for: UIBarMetrics.default)
        // 文件夹
        folder.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        folder.tabBarItem.title = "便签"
        folder.navigationBar.barTintColor = UIColor.white
        folder.edgesForExtendedLayout = .top
        folder.navigationBar.tintColor = APPDelStatic.themeColor
        folder.navigationBar.shadowImage = APPDelStatic.themeColor.toImage()
        folder.navigationBar.isTranslucent = false
        folder.tabBarItem.image = UIImage(named: "folderDeselected")
        folder.tabBarItem.selectedImage = UIImage(named: "folderSelected")
        folder.navigationBar.setBackgroundImage(UIColor.white.toImage(), for: UIBarMetrics.default)
        // 添加
        addding.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        addding.tabBarItem.title = "首页"
        addding.edgesForExtendedLayout = UIRectEdge.top
        addding.navigationBar.tintColor =  APPDelStatic.themeColor
        addding.tabBarItem.image = UIImage(named: "mianSelected")
        addding.navigationBar.isTranslucent = false
        addding.navigationBar.shadowImage = APPDelStatic.themeColor.toImage()
        addding.navigationBar.setBackgroundImage(UIColor.white.toImage(), for: UIBarMetrics.default)
        // 我的
        myInfo.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        myInfo.tabBarItem.title = "我的"
        myInfo.edgesForExtendedLayout = UIRectEdge.top
        myInfo.navigationBar.tintColor = APPDelStatic.themeColor
        myInfo.navigationBar.barTintColor = APPDelStatic.themeColor
        myInfo.navigationBar.isTranslucent = false
        myInfo.tabBarItem.image = UIImage(named: "mineDeselected")
        myInfo.tabBarItem.selectedImage = UIImage(named: "mineSelected")
        myInfo.navigationBar.setBackgroundImage(UIColor.white.toImage(), for: UIBarMetrics.default)
        myInfo.navigationBar.shadowImage = APPDelStatic.themeColor.toImage()
        // 全局设置
        self.viewControllers = [addding,folder,newest,myInfo]
        self.delegate = self
        self.tabBarController?.tabBar.isTranslucent = false
        dropShadow(offset: CGSize(width:0,height: -0.5), radius: 1, color: UIColor.black, opacity: 0.3)
        let barButtonView = folder.tabBarItem.value(forKeyPath: "_view") as! UIView
        let swappableImageView = barButtonView.subviews.first!
        let badgeWidth:CGFloat = 10
        badgeView = UIView(frame: CGRect(x: swappableImageView.frame.size.width - badgeWidth / 2, y:  -badgeWidth / 2 , width: badgeWidth, height: badgeWidth))
        badgeView.layer.masksToBounds = true;
        badgeView.layer.cornerRadius = badgeWidth / 2;
        swappableImageView.addSubview(badgeView)
        badgeView.isHidden = true
    }
    
    /**
     设置阴影
     
     - parameter offset:  偏移
     - parameter radius:  圆
     - parameter color:   颜色
     - parameter opacity: 光栅化
     */
    func dropShadow(offset:CGSize,radius:CGFloat,color:UIColor,opacity:Float){
        let path = CGMutablePath()
        path.addRect(self.tabBar.bounds)
        self.tabBar.layer.shadowPath = path;
        path.closeSubpath()
        self.tabBar.layer.shadowColor = color.cgColor
        self.tabBar.layer.shadowOffset = offset
        self.tabBar.layer.shadowRadius = radius
        self.tabBar.layer.shadowOpacity = opacity
        self.tabBar.clipsToBounds = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("tabar deinit")
    }
    
    
}
