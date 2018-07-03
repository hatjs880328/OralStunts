//
//  NoteVedioPlayBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/22.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


/// 当前类再使用过程中请将其设置为成员变量，防止vedio提前销毁
class NoteVedioPlayBLL: NSObject {
    
    var audioPlayer: PcmPlayer!
    
    /// 播放完毕回调函数
    var playEndAction:(()->Void)!
    
    override init() {
        super.init()
    }
    
    func playVideo(with pcmName:String) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onPlayCompleted(noti:)), name: NSNotification.Name.init("oralTruntsPlayOverNotification"), object: nil)
        let pathNew = try! FileManager.default.url(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("\(pcmName).pcm")
        audioPlayer = PcmPlayer(filePath: pathNew.absoluteString.substringFromIndex(7), sampleRate: 16000)
        audioPlayer!.play()
    }
    
    /// 播放完毕就移除通知，开始播放就添加监听
    @objc func onPlayCompleted(noti:Notification) {
        self.removeObser()
        if self.playEndAction == nil { return }
        self.playEndAction()
    }
    
    /// 移除通知
    func removeObser() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}
