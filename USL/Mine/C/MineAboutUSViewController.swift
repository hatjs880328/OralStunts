//
//  MineAboutUSViewController.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/24.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

class MineAboutUSViewController: IIBaseViewController {

    let sourceImg = SVGKImage(named: "语音.svg")

    var layers: [CAShapeLayer] = []

    var timer: Timer?

    var img: SVGKFastImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initVw()
        createTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initVw() {
        self.title = "关于我们"
        self.navigationController?.isNavigationBarHidden = false
        //分享
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "分享", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.share))
        img = SVGKFastImageView(svgkImage: sourceImg)!
        self.view.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view.snp.centerY).offset(-80 * APPDelStatic.sizeScale)
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(APPDelStatic.aWeight / 9 * 5)
            make.height.equalTo(APPDelStatic.aWeight / 9 * 5)
        }
        //title
        let titleLb = UILabel()
        self.view.addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.bottom.equalTo(-15)
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(APPDelStatic.aWeight)
            make.height.equalTo(12)
        }
        titleLb.textAlignment = .center
        titleLb.font = APPDelStatic.uiFont(with: 11)
        titleLb.text = "Copyright © 2018年 Noah_Shan. All rights reserved."
        // ver
        let ver = UILabel()
        self.view.addSubview(ver)
        ver.snp.makeConstraints { (make) in
            make.bottom.equalTo(titleLb.snp.top).offset(-15 * APPDelStatic.sizeScale)
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(APPDelStatic.aWeight)
            make.height.equalTo(13)
        }
        ver.textAlignment = .center
        ver.font = APPDelStatic.uiFont(with: 12)
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        ver.text = "Oral Ver \(version)"
    }

    func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.changeCGColor), userInfo: nil, repeats: true)
        self.layers.append((sourceImg?.layer(withIdentifier: "cureLine") as! CALayerWithChildHitTest).sublayers![0] as! CAShapeLayer)
        self.layers.append((sourceImg?.layer(withIdentifier: "外围椭圆") as! CALayerWithChildHitTest).sublayers![0] as! CAShapeLayer)
        for eachItem in (sourceImg?.layer(withIdentifier: "bottom") as! CALayerWithChildHitTest).sublayers! {
            self.layers.append(eachItem as! CAShapeLayer)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
    }

    deinit {
        print("关于我们释放")
    }

    @objc func changeCGColor() {
        let color = MineAboutUsBLL().changeColor().cgColor
        for eachItem in self.layers {
            eachItem.fillColor = color
        }
        self.img.setNeedsDisplay()
    }

    @objc func share() {
        OTShare.share(with: self.view, title: "OralStunts", subTitle: "生活琐事随地、随时记录。", img: "voice.png", shareUrl: URL(string: "http://baidu.com")!)
    }

}
