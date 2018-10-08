//
//  AddRightVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/23.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class AddRightVw: UIView {

    let helloLb = UIImageView()

    init(frame: CGRect, fatherVw: UIView) {
        super.init(frame: frame)
        fatherVw.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.top.equalTo(APPDelStatic.noNaviTopDistance + 15 * APPDelStatic.sizeScale)
            make.right.equalTo(-18)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        self.createVw()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createVw() {
        self.addSubview(helloLb)
        helloLb.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        helloLb.image = UIImage(named: "addRight.png")
        self.helloLb.tapActionsGesture {
            let con = FolderCreateViewController()
            self.viewController()?.navigationController?.pushViewController(con, animated: true)
        }
    }
}
