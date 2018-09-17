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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createVw()
        createTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        let note = UILabel()
        note.numberOfLines = 0
        self.addSubview(note)
        note.snp.makeConstraints { (make) in
            make.left.equalTo(10 * APPDelStatic.sizeScale)
            make.right.equalTo(-10 * APPDelStatic.sizeScale)
            make.centerY.equalTo(self.snp.centerY).offset(12)
            make.height.equalTo(12)
        }
        note.layer.cornerRadius = 4
        note.textAlignment = .center
        note.textColor = UIColor.gray
        note.font = APPDelStatic.uiFont(with: 10)
        note.text = "没什么内容,非常遗憾"
        img = SVGKFastImageView(svgkImage: sourceImg)!
        self.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.centerY).offset(-4)
            make.height.equalTo(55)
            make.width.equalTo(55)
        }
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
