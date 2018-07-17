//
//  VoiceBtnVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/22.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class VoiceBtnVw: UIView {
    
    var warningLb: UILabel = UILabel()
    
    let picWeight = APPDelStatic.aWeight / 2
    
    var vm: VoiceBtnVM!
    
    var warningTxt:String = ""
    
    var listeningTxt: String = "正在听写..."
    
    init(frame: CGRect,fatherVw: UIView,warningTxt:String) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.vm = VoiceBtnVM(warningTxt)
        self.warningTxt = warningTxt
        createVw()
        createVm()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(APPDelStatic.aWeight)
            make.height.equalTo((picWeight + 30) * APPDelStatic.sizeScale)
            make.bottom.equalTo(-15 * APPDelStatic.sizeScale)
        }
        self.addSubview(warningLb)
        warningLb.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(APPDelStatic.aWeight)
            make.height.equalTo(15 * APPDelStatic.sizeScale)
            make.top.equalTo(0)
        }
        warningLb.text = self.warningTxt
        warningLb.textAlignment = .center
        warningLb.textColor = UIColor.gray
        warningLb.font = APPDelStatic.uiFont(with: 14)
        // pic circle
        let picVwcircle = UIView()
        self.addSubview(picVwcircle)
        picVwcircle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(picWeight  * APPDelStatic.sizeScale)
            make.height.equalTo(picWeight  * APPDelStatic.sizeScale)
            make.top.equalTo(warningLb.snp.bottom).offset(10 * APPDelStatic.sizeScale)
        }
        picVwcircle.layer.cornerRadius = picWeight  * APPDelStatic.sizeScale / 2
        picVwcircle.layer.borderColor = APPDelStatic.lightGray.cgColor
        picVwcircle.layer.borderWidth = 1
        picVwcircle.layer.masksToBounds = true
        // pic
        let picVw: UIImageView = UIImageView()
        self.addSubview(picVw)
        picVw.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo((picWeight - 15)  * APPDelStatic.sizeScale)
            make.height.equalTo((picWeight - 15)  * APPDelStatic.sizeScale)
            make.centerY.equalTo(picVwcircle.snp.centerY)
        }
        picVw.image = UIImage(named: "voice.png")
    }
    
    func createVm() {
        self.vm.volumeAction = { int32Value in
            if let contextVC = self.viewController() as? NoteContextCreateViewController {
                contextVC.contextVw.vm.postVolume(int32Value)
            }
            if let createVC = self.viewController() as? NoteCreateViewController {
                createVC.titleVw.vm.postVolume(int32Value)
            }
            if let recontentVC = self.viewController() as? NoteContextReCreateViewController {
                recontentVC.contextVw.vm.postVolume(int32Value)
            }
        }
        
        self.vm.resultAction = { resultValue in
            if let createVC = self.viewController() as? NoteCreateViewController {
                createVC.titleVw.vm.postTitle(resultValue)
            }
            if let contextVC = self.viewController() as? NoteContextCreateViewController {
                contextVC.contextVw.vm.postTitle(resultValue)
            }
            if let recontentVC = self.viewController() as? NoteContextReCreateViewController {
                recontentVC.contextVw.vm.postTitle(resultValue)
            }
        }
        
        self.vm.warningTxtChangeAction = { txt in
            self.warningLb.text = txt
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.vm.start()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.vm.stop()
    }
}
