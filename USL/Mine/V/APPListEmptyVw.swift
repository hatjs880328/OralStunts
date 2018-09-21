//
//  APPListEmptyVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/17.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

class APPListEmptyVw: UIView {
    
    let sourceImg = SVGKImage(named: "语音.svg")
    
    var timer: Timer?
    
    var layers: [CAShapeLayer] = []
    
    var img:SVGKFastImageView!
    
    let createTxt = "在此新建"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createVw()
        createTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        img = SVGKFastImageView(svgkImage: sourceImg)!
        self.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.centerY).offset(-45)
            make.height.equalTo(55)
            make.width.equalTo(55)
        }
        let note = UILabel()
        note.numberOfLines = 0
        self.addSubview(note)
        note.snp.makeConstraints { (make) in
            make.left.equalTo(10 * APPDelStatic.sizeScale)
            make.right.equalTo(-10 * APPDelStatic.sizeScale)
            make.top.equalTo(img.snp.bottom).offset(10)
            make.height.equalTo(12)
        }
        note.layer.cornerRadius = 4
        note.textAlignment = .center
        note.textColor = UIColor.gray
        note.font = APPDelStatic.uiFont(with: 10)
        note.text = "没什么内容,非常遗憾"
        let createBtn = UIButton()
        self.addSubview(createBtn)
        createBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(note.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(IITextExtension.textLength(text: createTxt, font: APPDelStatic.uiFont(with: 13)))
        }
        createBtn.setTitle(self.createTxt, for: UIControlState.normal)
        createBtn.tapActionsGesture {
//            let con = NoteCreateViewController()
//            con.hidesBottomBarWhenPushed = true
//            con.presentedVcHasNavigation = false
//            self.viewController()?.navigationController?.pushViewController(con, animated: true)
            OTAlertVw().alertShowCreateNoteAndFolderVw()
        }
        createBtn.borderWidth = 0.5
        createBtn.borderColor = APPDelStatic.themeColor
        createBtn.setTitleColor(APPDelStatic.themeColor, for: UIControlState.normal)
        createBtn.titleLabel?.font = APPDelStatic.uiFont(with: 13)
        createBtn.cornerRadiu = 3
    }
    
    func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.changeCGColor), userInfo: nil, repeats: true)
        self.layers.append((sourceImg?.layer(withIdentifier: "cureLine") as! CALayerWithChildHitTest).sublayers![0] as! CAShapeLayer)
        self.layers.append((sourceImg?.layer(withIdentifier: "外围椭圆") as! CALayerWithChildHitTest).sublayers![0] as! CAShapeLayer)
        for eachItem in (sourceImg?.layer(withIdentifier: "bottom") as! CALayerWithChildHitTest).sublayers! {
            self.layers.append(eachItem as! CAShapeLayer)
        }
    }
    
    @objc func changeCGColor() {
        let color = MineAboutUsBLL().changeColor().cgColor
        for eachItem in self.layers {
            eachItem.fillColor = color
        }
        self.img.setNeedsDisplay()
    }
}
