//
//  OTPlayVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/8/30.
//  Copyright © 2018 Inspur. All rights reserved.
//

/// 播放动画-参考爱奇艺，使用swift实现
import Foundation


class OTPlayVw: UIView {
    var leftLine: OTPlayLeftLine?
    var rightline: OTPlayRightLine?
    var rectLine: OTPlayRectLine?
    
    var flag = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = UIColor.yellow
        rectLine = OTPlayRectLine(width: frame.size.width)
        self.layer.addSublayer(rectLine!)
        leftLine = OTPlayLeftLine(width: frame.size.width)
        self.layer.addSublayer(leftLine!)
        rightline = OTPlayRightLine(width: frame.size.width)
        self.layer.addSublayer(rightline!)
    }
    
    func goAni() {
        if flag == 0 {
            self.rectLine?.goAni()
            GCDUtils.delayProgerssWithFloatSec(milliseconds: 400) {
                self.leftLine?.goAni()
                self.rightline?.goAni()
            }
            flag = 1
        }else{
            flag = 0
            self.leftLine?.backAni()
            self.rightline?.backAni()
            GCDUtils.delayProgerssWithFloatSec(milliseconds: 300) {
                self.rectLine?.backAni()
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error")
    }
    
}


class OTPlayRectLine: CAShapeLayer {
    
    var rectWidth: CGFloat = 0
    
    var durationTime:CFTimeInterval = 0.4
    /// 距离右边的百分比
    var disRight:CGFloat = 3
    
    init(width: CGFloat) {
        super.init()
        self.rectWidth = width
        self.lineWidth = 1.5
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = APPDelStatic.themeColor.cgColor
        self.path = realPath.cgPath
        
    }
    
    var realPath: UIBezierPath {
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: 0, y: 0))
        path1.addLine(to: CGPoint(x: rectWidth / disRight * (disRight - 1), y: rectWidth / 2))
        path1.addLine(to: CGPoint(x: 0, y: rectWidth))
        path1.addLine(to: CGPoint(x: 0, y: -0.5))
        
        return path1
    }
    
    func goAni() {
        let ani = CABasicAnimation(keyPath: "strokeEnd")
        ani.fromValue = 1
        ani.toValue = 0
        ani.beginTime = 0.0
        ani.duration = durationTime
        
        let aniGroup = CAAnimationGroup()
        aniGroup.animations = [ani]
        aniGroup.isRemovedOnCompletion = false
        aniGroup.duration = durationTime
        aniGroup.fillMode = kCAFillModeForwards
        self.add(aniGroup, forKey: nil)
    }
    
    func backAni() {
        let ani = CABasicAnimation(keyPath: "strokeEnd")
        ani.fromValue = 0
        ani.toValue = 1
        ani.beginTime = 0.0
        ani.duration = durationTime
        
        let aniGroup = CAAnimationGroup()
        aniGroup.animations = [ani]
        aniGroup.isRemovedOnCompletion = false
        aniGroup.duration = durationTime
        aniGroup.fillMode = kCAFillModeForwards
        self.add(aniGroup, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class OTPlayLeftLine: CAShapeLayer {
    var durationTime:CFTimeInterval = 0.3
    var realWidth: CGFloat = 0
    /// 竖线距离左右两边的百分比
    var sepCount:CGFloat = 4
    /// 竖线距离顶部的距离
    var disTop: CGFloat = 4
    init(width: CGFloat) {
        super.init()
        self.realWidth = width
        self.lineWidth = 1.5
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = APPDelStatic.themeColor.cgColor
        self.path = initPath.cgPath
    }
    
    var initPath: UIBezierPath {
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: 0, y: disTop))
        path1.addLine(to: CGPoint(x: 0, y: disTop))
        path1.close()
        return path1
    }
    
    var realPath: UIBezierPath {
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: 0, y: disTop))
        path1.addLine(to: CGPoint(x: 0, y: realWidth - disTop))
        path1.close()
        return path1
    }
    
    func goAni() {
        let ani = CABasicAnimation(keyPath: "path")
        ani.fromValue = initPath.cgPath
        ani.toValue = realPath.cgPath
        ani.beginTime = 0.0
        ani.duration = durationTime
        
        let aniGroup = CAAnimationGroup()
        aniGroup.animations = [ani]
        aniGroup.isRemovedOnCompletion = false
        aniGroup.duration = durationTime
        aniGroup.fillMode = kCAFillModeForwards
        self.add(aniGroup, forKey: nil)
    }
    
    func backAni() {
        let ani = CABasicAnimation(keyPath: "path")
        ani.fromValue = realPath.cgPath
        ani.toValue = initPath.cgPath
        ani.beginTime = 0.0
        ani.duration = durationTime
        
        let aniGroup = CAAnimationGroup()
        aniGroup.animations = [ani]
        aniGroup.isRemovedOnCompletion = false
        aniGroup.duration = durationTime
        aniGroup.fillMode = kCAFillModeForwards
        self.add(aniGroup, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class OTPlayRightLine: CAShapeLayer,CAAnimationDelegate {
    var durationTime:CFTimeInterval = 0.3
    var realWidth: CGFloat = 0
    /// 竖线距离左右两边的百分比
    var sepCount:CGFloat = 4
    /// 竖线距离顶部的距离
    var disTop: CGFloat = 4
    init(width: CGFloat) {
        super.init()
        self.realWidth = width
        self.lineWidth = 1.5
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = APPDelStatic.themeColor.cgColor
        self.path = initPath.cgPath
    }
    
    var realPath: UIBezierPath {
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: realWidth / sepCount * (sepCount - 2), y: realWidth - disTop))
        path1.addLine(to: CGPoint(x: realWidth / sepCount * (sepCount - 2), y: disTop))
        path1.close()
        return path1
    }
    
    var initPath: UIBezierPath {
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: realWidth / sepCount * (sepCount - 2), y: realWidth - disTop))
        path1.addLine(to: CGPoint(x: realWidth / sepCount * (sepCount - 2), y: realWidth - disTop))
        path1.close()
        return path1
    }
    
    func goAni() {
        let ani = CABasicAnimation(keyPath: "path")
        ani.fromValue = initPath.cgPath
        ani.toValue = realPath.cgPath
        ani.beginTime = 0.0
        ani.duration = durationTime
        
        let aniGroup = CAAnimationGroup()
        aniGroup.animations = [ani]
        aniGroup.isRemovedOnCompletion = false
        aniGroup.duration = durationTime
        aniGroup.fillMode = kCAFillModeForwards
        self.add(aniGroup, forKey: nil)
    }
    
    func backAni() {
        let ani = CABasicAnimation(keyPath: "path")
        ani.fromValue = realPath.cgPath
        ani.toValue = initPath.cgPath
        ani.beginTime = 0.0
        ani.duration = durationTime
        
        let aniGroup = CAAnimationGroup()
        aniGroup.animations = [ani]
        aniGroup.isRemovedOnCompletion = false
        aniGroup.duration = durationTime
        aniGroup.fillMode = kCAFillModeForwards
        aniGroup.delegate = self
        self.add(aniGroup, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
}
