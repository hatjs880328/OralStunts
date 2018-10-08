//
//  ShelterVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/25.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class ShelterVw: UIView {
    var tapAction:(() -> Void)!
    init(frame: CGRect, fatherVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        self.backgroundColor = APPDelStatic.lightGray
        self.alpha = 0
        self.tapActionsGesture {[weak self]() in
            if self?.tapAction == nil { return }
            self?.tapAction()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showSelf() {
        self.alpha = 0.6
    }

    func hiddenSelf() {
        self.alpha = 0
    }

}
