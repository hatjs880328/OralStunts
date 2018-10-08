//
//  AudioPlay.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/8/29.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation
import AudioToolbox

/// 对语音进行播放-空文件不播放，靠近耳朵是听筒，远离是外放
class AudioPlay: NSObject, AVAudioPlayerDelegate {
    var player: AVAudioPlayer?
    init(with data: NSData) {
        super.init()
        //添加红外感应监听
        UIDevice.current.isProximityMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.sensorStateChange(noti:)), name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification"), object: nil)
        try! player = AVAudioPlayer(data: data as Data)
        player?.prepareToPlay()
        player?.delegate = self
        player?.volume = 1.1
    }

    func play() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
            try session.setActive(true)
        } catch {
            print(error)
        }
        if player!.data!.count <= 44 {
            postNotification()
        }
        self.player?.play()
    }

    @objc func sensorStateChange(noti: Notification) {
        do {
            if UIDevice.current.proximityState {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
                try AVAudioSession.sharedInstance().setActive(true)
            } else {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
            }
        } catch {}
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //播放结束的回调
        postNotification()
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        //错误回调
        postNotification()
    }

    /// 发送结束通知 & 关闭红外感应
    func postNotification() {
        UIDevice.current.isProximityMonitoringEnabled = false
        NotificationCenter.default.post(name: NSNotification.Name("oralTruntsPlayOverNotification"), object: nil, userInfo: nil)
    }

}
