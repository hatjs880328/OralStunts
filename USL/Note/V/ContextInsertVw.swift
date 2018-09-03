//
//  ContextInsertVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/22.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ContextInsertVw: UIView {
    
    let titleTF = UITextView()
    
    let vm = ContextInsertVM()
    
    var aniVw = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    var voiceAniVw: OTVolumeVw!
    
    var donePub = PublishSubject<(String,[Int32])>()
    
    var reCreateDonePub = PublishSubject<(String,[Int32])>()
    
    var iflyVoiceAniPreVw = UIButton()
    
    var topVw: UIView?
    
    init(frame: CGRect,fatherVw: UIView,topVw: UIView? = nil) {
        super.init(frame: frame)
        self.topVw = topVw
        fatherVw.addSubview(self)
        createVw()
        createRX()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        if self.topVw == nil {
            self.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(0)
                make.height.equalTo(260 * APPDelStatic.sizeScale)
            }
        }else{
            self.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(self.topVw!.snp.bottom)
                make.height.equalTo(260 * APPDelStatic.sizeScale)
            }
        }
        // 容器view
        let contentVw: UIView = UIView()
        self.addSubview(contentVw)
        contentVw.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(10 * APPDelStatic.sizeScale)
            make.height.equalTo(240 * APPDelStatic.sizeScale)
        }
        contentVw.layer.cornerRadius = 4
        contentVw.layer.borderColor = UIColor.gray.cgColor
        contentVw.layer.borderWidth = 0.5
        //语音和文字间隔线条
        let line = UIView()
        contentVw.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(29 * APPDelStatic.sizeScale)
            make.height.equalTo(0.5)
        }
        line.backgroundColor = APPDelStatic.lightGray
        //动画开始之前的图片
        contentVw.addSubview(iflyVoiceAniPreVw)
        iflyVoiceAniPreVw.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.equalTo(5)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        iflyVoiceAniPreVw.setImage(UIImage(named: "iflyVoiceStart"), for: UIControlState.normal)
        iflyVoiceAniPreVw.setImage(UIImage(named: "iflyVoiceEnd"), for: UIControlState.selected)
        //小菊花
        contentVw.addSubview(aniVw)
        //aniVw.backgroundColor = UIColor.black
        aniVw.frame.origin = CGPoint(x: 5, y: 5)
        aniVw.frame.size = CGSize(width: 20, height: 20)
        //语音动画view
        voiceAniVw = OTVolumeVw(frame: CGRect.zero, fatherVw: contentVw)
        //标题 field
        contentVw.addSubview(titleTF)
        titleTF.snp.makeConstraints { (make) in
            make.left.equalTo(5 * APPDelStatic.sizeScale)
            make.right.equalTo(-5 * APPDelStatic.sizeScale)
            make.top.equalTo(30 * APPDelStatic.sizeScale)
            make.height.equalTo(200 * APPDelStatic.sizeScale)
        }
        titleTF.font = APPDelStatic.uiFont(with: 11)
        titleTF.textAlignment = .left
        // 底部提示语图片
        let warnPic = UIImageView()
        self.addSubview(warnPic)
        warnPic.snp.makeConstraints { (make) in
            make.width.equalTo(15)
            make.left.equalTo(18)
            make.top.equalTo(contentVw.snp.bottom).offset(5 * APPDelStatic.sizeScale)
            make.height.equalTo(15)
        }
        warnPic.image = UIImage(named: "warning.png")
        // 底部提示语
        let warnTxt = UILabel()
        self.addSubview(warnTxt)
        warnTxt.snp.makeConstraints { (make) in
            make.right.equalTo(-18)
            make.left.equalTo(warnPic.snp.right).offset(5 * APPDelStatic.sizeScale)
            make.centerY.equalTo(warnPic.snp.centerY)
            make.height.equalTo(15 * APPDelStatic.sizeScale)
        }
        warnTxt.font = APPDelStatic.uiFont(with: 11)
        warnTxt.textColor = UIColor.gray
        warnTxt.text = "点击右上角的完成按钮编辑结束"
    }
    
    func createRX() {
        let _ = self.vm.titlePublisher.subscribe { [weak self](strValue) in
            if strValue.element == nil { return }
            self?.titleTF.text = strValue.element!
            self?.progressIflyAniPreVw(aniStart: false)
            self?.aniVw.stopAnimating()
        }
        let _ = self.vm.volumePublisher.subscribe { [weak self](intvalue) in
            if intvalue.element == nil { return }
            self?.progressIflyAniPreVw(aniStart: true)
            self?.aniVw.startAnimating()
            self?.voiceAniVw.setValue(value: intvalue.element!)
        }
        //创建时信号量
        let _ = self.donePub.bind(to: self.vm.dongInput)
        let _ = self.vm.outPutSignal.subscribe { [weak self](event) in
            if event.element == nil || event.element == false {
                self?.showAlert()
                return
            }
            if let con = self?.viewController() as? NoteContextCreateViewController {
                con.goMainPage()
            }
        }
        //编辑、修改时信号量
        let _ = self.reCreateDonePub.bind(to: self.vm.reCreateInput)
        let _ = self.vm.reCreateOutput.subscribe { [weak self](event) in
            if event.element == nil || event.element == false {
                self?.showAlert()
                return
            }
            if let con = self?.viewController() as? NoteContextReCreateViewController {
                con.goBack()
            }
        }
    }
    
    func showAlert() {
        OTAlertVw().alertShowSingleTitle(titleInfo: "提醒", message: "内容不可为空！", from: self.viewController()!)
    }
    
    func postDoneSignal() {
        self.donePub.onNext((self.titleTF.text!,self.voiceAniVw.volumeList))
    }
    
    func postRecreateSignal() {
        self.reCreateDonePub.onNext((self.titleTF.text!,self.voiceAniVw.volumeList))
    }
    
    /// 菊花上面的预制图片变换规则
    func progressIflyAniPreVw(aniStart:Bool) {
        //菊花动画开始
        if aniStart {
            self.iflyVoiceAniPreVw.alpha = 0
            self.iflyVoiceAniPreVw.isSelected = true
        }else{
            //菊花动画结束
            self.iflyVoiceAniPreVw.alpha = 1
        }
    }
}
