//
//  OTSearchVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class OTSearchVw: UIView {

    var searFd = UISearchBar()

    var vm = OTSearchVM()

    var alphaBtn = UIButton()

    /// true: jump - false : use
    var jumpOrUse: Bool = false

    init(frame: CGRect, fatherVw: UIView, topVw: UIView?, jumpOrUse: Bool = true) {
        super.init(frame: frame)
        self.jumpOrUse = jumpOrUse
        fatherVw.addSubview(self)

        if topVw == nil {
            self.snp.makeConstraints { (make) in
                make.left.equalTo(18)
                make.right.equalTo(-18)
                make.top.equalTo(APPDelStatic.noNaviTopDistance)
                make.height.equalTo(50 * APPDelStatic.sizeScale)
            }
        } else {
            self.snp.makeConstraints { (make) in
                make.left.equalTo(18)
                make.right.equalTo(-18)
                make.top.equalTo(topVw!.snp.bottom).offset(10)
                make.height.equalTo(50 * APPDelStatic.sizeScale)
            }
        }
        createVw()
        createRX()
    }

    func remakeCon(right: CGFloat) {
        self.searFd.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: right))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createVw() {
        self.addSubview(searFd)
        searFd.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        searFd.barStyle = .default
        searFd.searchBarStyle = .minimal
        searFd.placeholder = "搜搜"
        if jumpOrUse {
            self.addSubview(alphaBtn)
            alphaBtn.snp.makeConstraints { (make) in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            }
            alphaBtn.backgroundColor = UIColor.white
            alphaBtn.alpha = 0.1
        }
    }

    func setPlaceHolderStr(with strValue: String) {
        self.searFd.placeholder = strValue
    }

    func createRX() {
        self.vm.con = self.viewController()!
        if self.jumpOrUse {
            _ = alphaBtn.rx.tap
                .throttle(0.8, scheduler: MainScheduler.instance)
                .bind(to: self.vm.didEditingPub)
            _ = self.vm.didEditingOB.subscribe { [weak self](_) in
                if self == nil { return }
                IIModuleCore.getInstance().invokingSomeFunciton(url: "SearchServiceModule/jumpToSearchVCWithParams:", params: ["fromVC": self!.viewController()!], action: nil)
            }
        } else {
            _ = self.searFd.rx.text.orEmpty
                .throttle(0.5, scheduler: MainScheduler.instance)
                .bind(to: self.vm.searchFdInput)

            _ = self.vm.searchFdOutput.subscribe { () in  }
        }
    }
}
