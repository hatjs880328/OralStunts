//
//  TitleInsertVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/21.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TitleInsertVw: UIView {
    
    let titleTF = UITextField()
    
    let vm = TtileInsertVM()
    
    let arrow = UIImageView()
    
    var jumpPub = PublishSubject<(String,[Int32])>()
    
    var voiceAniVw: OTVolumeVw!
    
    var aniVw = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    var iflyVoiceAniPreVw: UIButton = UIButton()
    
    init(frame: CGRect,fatherVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        createVw()
        createRX()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(130 * APPDelStatic.sizeScale)
        }
        // 容器view
        let contentVw: UIView = UIView()
        self.addSubview(contentVw)
        contentVw.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(20 * APPDelStatic.sizeScale)
            make.height.equalTo(80 * APPDelStatic.sizeScale)
        }
        contentVw.layer.cornerRadius = 4
        contentVw.layer.borderColor = UIColor.gray.cgColor
        contentVw.layer.borderWidth = 0.5
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
        aniVw.frame.origin = CGPoint(x: 5, y: 5)
        aniVw.frame.size = CGSize(width: 20, height: 20)
        // 语音动画view
        voiceAniVw = OTVolumeVw(frame: CGRect.zero, fatherVw: contentVw)
        //标题 field
        contentVw.addSubview(titleTF)
        titleTF.snp.makeConstraints { (make) in
            make.left.equalTo(10 * APPDelStatic.sizeScale)
            make.right.equalTo(-50 * APPDelStatic.sizeScale)
            make.bottom.equalTo(-10)
            make.height.equalTo(15 * APPDelStatic.sizeScale)
        }
        titleTF.placeholder = "标题"
        titleTF.font = APPDelStatic.uiFont(with: 12)
        titleTF.textAlignment = .center
        // 前进箭头
        contentVw.addSubview(arrow)
        arrow.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.width.equalTo(25 * APPDelStatic.sizeScale)
            make.top.equalTo(10 * APPDelStatic.sizeScale)
            make.bottom.equalTo(-10 * APPDelStatic.sizeScale)
        }
        arrow.image = UIImage(named: "more.png")
        arrow.tapActionsGesture {[weak self]() in
            if self == nil { return }
            self?.jumpPub.onNext((self!.titleTF.text!,self!.voiceAniVw.volumeList))
        }
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
        warnTxt.text = "点击向右的箭头进入正文编辑"
    }
    
    func createRX() {
        let _ = self.vm.titlePublisher.subscribe { [weak self](strValue) in
            if strValue.element == nil { return }
            self?.titleTF.text = strValue.element!
            self?.progressIflyAniPreVw(aniStart: false)
            self?.aniVw.stopAnimating()
        }
        
        let _ = self.jumpPub.bind(to: self.vm.jumpInput)
        
        let _ = self.vm.outPut.asObservable().subscribe { [weak self](boolValue) in
            if boolValue.element == nil { return }
            self?.jumpNextVC(boolValue.element!)
        }
        
        let _ = self.vm.volumePublisher.subscribe { [weak self](intvalue) in
            if intvalue.element == nil || self == nil { return }
            self?.aniVw.startAnimating()
            self?.progressIflyAniPreVw(aniStart: true)
            self?.voiceAniVw.setValue(value: intvalue.element!)
        }
        
    }
    
    func jumpNextVC(_ boolValue:Bool) {
        if !boolValue {
            OTAlertVw().alertShowSingleTitle(titleInfo: "提醒", message: "标题不能为空！")
            return
        }
        let con = NoteContextCreateViewController()
        con.presentedVcHasNavigation = true
        self.viewController()?.navigationController?.pushViewController(con, animated: true)
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
