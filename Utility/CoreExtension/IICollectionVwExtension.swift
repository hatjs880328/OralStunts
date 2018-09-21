//
//  IICollectionVwExtension.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/21.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation
import UIKit

/*
 此处为uicollectionview处理method-swizzing
 由于aspects库无法处理相同父类下不同子类之间同名方法的替换-所以这里手动替换
 声明静态方法手动调用-initializeMethod[在swift4.0+，load & initilize方法都已经失效]
 
 */
extension UICollectionView {
    
    public class func initializeMethod(){
        let originalSelector = #selector(UICollectionView.reloadData)
        let swizzledSelector = #selector(UICollectionView.swizzingReload)
        
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
    
    @objc func swizzingReload() {
        self.swizzingReload()
        if !self.isKind(of: UICollectionView.self) { return }
        if !self.tableReloadNumber {
            return
        }
        GCDUtils.delayProgerssWithFloatSec(milliseconds: 200, yourFunc: {
            for eachItem in self.subviews {
                if eachItem.isKind(of: IIBaseWaitAniVw.self) {
                    eachItem.removeFromSuperview()
                    break
                }
            }
            let boolStr = IIModuleCore.getInstance().invokingSomeFunciton(url: "MineServiceModule/isShowAlertInfo", params: nil, action: nil)
            if boolStr == nil { return }
            if (boolStr as! String) == "true" {
                if self.numberOfItems(inSection: 0) != 0 {
                    self.backgroundView = nil
                }else{
                    let resultVw = IIModuleCore.getInstance().invokingSomeFunciton(url: "MineServiceModule/getAlertVwWithParams:", params: ["frame":self.frame], action: nil)
                    self.backgroundView = resultVw as? UIView
                }
            }else {
                self.backgroundView = nil
                return
            }
        })
    }
}
