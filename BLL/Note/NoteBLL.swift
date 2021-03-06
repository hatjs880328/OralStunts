//
//  NoteBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/22.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

/*
 
 ifly msc progress
 
 
 */

class NoteBLL: NSObject, IFlySpeechRecognizerDelegate {

    // 识别实例
    let flySpeechRec = IFlySpeechRecognizer.sharedInstance()

    // 结果action
    var resultAction: ((_ resultInfo: String) -> Void)!

    // 音量action
    var volumeAction: ((_ volumeNow: Int32) -> Void)!

    // 集中记录识别的字符
    var resultTxt: String = ""

    /// 音频文件名字
    var videoDataName: String = ""

    init(with videoName: String) {
        super.init()
        self.videoDataName = videoName
        setFSRIns()
    }

    /// 参数设置
    func setFSRIns() {
        self.flySpeechRec?.setParameter("iat", forKey: IFlySpeechConstant.ifly_DOMAIN())
        self.flySpeechRec?.setParameter("\(self.videoDataName).pcm", forKey: IFlySpeechConstant.asr_AUDIO_PATH())
        self.flySpeechRec?.setParameter("16000", forKey: IFlySpeechConstant.mfv_DATA_FORMAT())
        self.flySpeechRec?.setParameter("100", forKey: IFlySpeechConstant.volume())
        self.flySpeechRec?.delegate = self
    }

    /// 重新设置保存文件的文件名字
    public func reSetFSRIns(contentName: String) {
        self.flySpeechRec?.setParameter("\(contentName).pcm", forKey: IFlySpeechConstant.asr_AUDIO_PATH())
    }

    /// 启动服务
    func startService() {
        self.flySpeechRec?.startListening()
    }

    /// 结束服务
    func stopService() {
        self.flySpeechRec?.stopListening()
    }

    /// 取消此次识别服务
    func cancelService() {
        self.flySpeechRec?.cancel()
    }

    // MARK: 协议实现：

    // 识别结果返回代理
    func onResults(_ results: [Any]!, isLast: Bool) {
        if results == nil { return }
        guard let dic = results[0] as? NSDictionary else {
            return
        }
        for key in dic {
            do {
                guard let data = ((key.key as? String) as NSString?)?.data(using: String.Encoding.utf8.rawValue) else {
                    return
                }
                guard let changeData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary else { return }
                guard let wsDics = changeData["ws"] as? NSArray else { return }
                for wsDic in wsDics {
                    guard let realCWDic = (wsDic as? NSDictionary) else { return }
                    guard let cwDic = realCWDic["cw"] as? NSArray else { return }
                    guard let realCWDicZero = (cwDic[0] as? NSDictionary) else { return }
                    guard let wDic = realCWDicZero["w"] as? String else { return }
                    resultTxt += wDic
                }
            } catch {}
        }
        if isLast {
            if self.resultAction == nil { return }
            self.resultAction(resultTxt)
            resultTxt = ""
        }
    }

    // 识别会话结束返回代理
    func onError(_ errorCode: IFlySpeechError!) {
        //print(errorCode)
    }

    // 停止录音回调
    func onEndOfSpeech() {

    }

    // 会话开启回调
    func onBeginOfSpeech() {

    }

    // 会话取消回调
    func onCancel() {

    }

    // 音量回调函数 0-30
    func onVolumeChanged(_ volume: Int32) {
        if self.volumeAction == nil { return }
        self.volumeAction(volume)
    }
}
