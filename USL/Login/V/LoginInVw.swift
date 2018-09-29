//
//  LoginInVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class LoginInVw: UIView,UITextFieldDelegate {
    
    let vm = LoginInVM()
    
    let loginBtn = UIButton()
    
    /// 印象笔记登陆按钮
    let evernoteLoginBtn = UIButton()
    
    let nickName: UITextField = UITextField()
    
    let sourceImg = SVGKImage(named: "语音.svg")
    
    var layers: [CAShapeLayer] = []
    
    var timer: Timer?
    
    var img: SVGKFastImageView!
    
    init(frame: CGRect,fatherVw:UIView) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(0)
        }
        self.createVw()
        self.createAni()
        self.progressRX()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.img = SVGKFastImageView(svgkImage: self.sourceImg)
        self.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.centerY)
            make.height.equalTo(APPDelStatic.aHeight / 4)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(APPDelStatic.aHeight / 4)
        }
        // nick name
        self.addSubview(nickName)
        nickName.snp.makeConstraints { (make) in
            make.top.equalTo(img.snp.bottom).offset(40 * APPDelStatic.sizeScale)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(APPDelStatic.aWeight / 4 * 3)
            make.height.equalTo(45 * APPDelStatic.sizeScale)
        }
        nickName.placeholder = "设置昵称(最少2位)"
        nickName.layer.cornerRadius = 6 * APPDelStatic.sizeScale
        nickName.layer.borderColor = UIColor.black.cgColor
        nickName.layer.borderWidth = 1
        nickName.delegate = self
        nickName.textAlignment = .center
        nickName.textColor = APPDelStatic.themeColor
        nickName.font = APPDelStatic.uiFont(with: 15)
        // login btn
        self.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(nickName.snp.left)
            make.right.equalTo(nickName.snp.right)
            make.top.equalTo(nickName.snp.bottom).offset(25 * APPDelStatic.sizeScale)
            make.height.equalTo(nickName.snp.height)
        }
        loginBtn.isEnabled = false
        loginBtn.layer.cornerRadius = 6 * APPDelStatic.sizeScale
        loginBtn.layer.borderColor = APPDelStatic.lightGray.cgColor
        loginBtn.layer.borderWidth = 1
        loginBtn.titleLabel?.font = APPDelStatic.uiFont(with: 12)
        loginBtn.setTitle("开始使用", for: UIControlState.normal)
        loginBtn.setTitleColor(APPDelStatic.lightGray, for: UIControlState.normal)
        // 印象笔记按钮
//        self.addSubview(evernoteLoginBtn)
//        evernoteLoginBtn.snp.makeConstraints { (make) in
//            make.left.equalTo(nickName.snp.left)
//            make.right.equalTo(nickName.snp.right)
//            make.top.equalTo(loginBtn.snp.bottom).offset(25 * APPDelStatic.sizeScale)
//            make.height.equalTo(nickName.snp.height)
//        }
//        evernoteLoginBtn.titleLabel?.font = APPDelStatic.uiFont(with: 12)
//        evernoteLoginBtn.titleLabel?.textAlignment = .right
//        evernoteLoginBtn.setTitle("使用印象笔记授权登陆", for: UIControlState.normal)
//        evernoteLoginBtn.setTitleColor(APPDelStatic.themeColor, for: UIControlState.normal)
//        evernoteLoginBtn.tapActionsGesture { [weak self] () in
//            self?.authEVER()
//        }
    }
    
    /// 更改动画在主线程，别搞事
    func createAni() {
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.changeCGColor), userInfo: nil, repeats: true)
        self.layers.append((sourceImg?.layer(withIdentifier: "cureLine") as! CALayerWithChildHitTest).sublayers![0] as! CAShapeLayer)
        self.layers.append((sourceImg?.layer(withIdentifier: "外围椭圆") as! CALayerWithChildHitTest).sublayers![0] as! CAShapeLayer)
        for eachItem in (sourceImg?.layer(withIdentifier: "bottom") as! CALayerWithChildHitTest).sublayers! {
            self.layers.append(eachItem as! CAShapeLayer)
        }
    }
    
    func progressRX() {
        let _ = nickName.rx.text.orEmpty.bind(to: self.vm.txtInput)
        let _ = self.vm.txtOutput.subscribe { [weak self](events) in
            if events.element == nil { return }
            self?.loginBtn.isEnabled = events.element!.0
            self?.loginBtn.setTitleColor(events.element!.1, for: UIControlState.normal)
            self?.loginBtn.layer.borderColor = events.element!.1.cgColor
        }
        
        let _ = loginBtn.rx.tap
        .throttle(0.8, scheduler: MainScheduler.instance)
        .bind(to: self.vm.didInput)
        let _ = self.vm.didOutput.subscribe { (event) in
            let tabbar = SaltedFishTabBarVC()
            //self.viewController()?.present(tabbar, animated: true, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController = tabbar
        }
    }
    
    /// 认证印象笔记
    func authEVER() {
        //ThirdLoginBLL().invokingNoteAuth(vc: self.ViewController()!)
        ThirdLoginBLL().getTemporaryToken()
    }
    
    @objc func changeCGColor() {
        IIGCDUtility.async(lvl: IIGCDQos.high, action: {
            let color = MineAboutUsBLL().changeColor().cgColor
            for eachItem in self.layers {
                eachItem.fillColor = color
            }
            
        }) {
            self.img.setNeedsDisplay()
        }
        
    }
    
    func deinitTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
