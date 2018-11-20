//
//  NoteVedioPlayBLL.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/22.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

/// 一条记录多语音处理方式：文件保存按照id递归保存，播放时取出前缀符合标准的所有语音文件依次播放
/// 如： xxxx-content-0 ~ 1    xxxx-content-0 ~ 2 xxxx-content-0 ~ 3
/// 当前类再使用过程中请将其设置为成员变量，防止vedio提前销毁
class NoteVedioPlayBLL: NSObject {

    var audioPlayer: PcmPlayer!

    var realPlayer: AudioPlay!

    var pathNew: URL!

    /// 播放完毕回调函数
    var playEndAction:(() -> Void)!

    /// pcm前缀 uuid ~ content ~ 0
    var contentPCMFileName = ""

    /// 所有需要播放文件的路径集合
    var contentsArr: [String] = []

    override init() {
        super.init()
    }

    func playVideo(with pcmName: String) {
        // 文件头内容
        self.contentPCMFileName = pcmName
        // 文件获取
        let fileArr = self.getContentFromFolderDESC()
        let headerPath = self.getDocumentsPath()
        for i in fileArr {
            self.contentsArr.append(headerPath + i)
        }
        // 添加监听
        NotificationCenter.default.addObserver(self, selector: #selector(self.onPlayCompleted(noti:)), name: NSNotification.Name("oralTruntsPlayOverNotification"), object: nil)
        // 播放第一条
        self.playPCMFile(filePath: self.contentsArr.first)
    }

    /// 根据路径播放
    func playPCMFile(filePath: String?) {
        if filePath == nil {
            self.removeObser()
            if self.playEndAction == nil { return }
            self.playEndAction()
            return
        }
        audioPlayer = PcmPlayer(filePath: filePath, sampleRate: 16_000)
        realPlayer = AudioPlay(with: audioPlayer.realpcmData)
        realPlayer.play()
    }

    /// 播放完毕就移除通知，开始播放就添加监听
    @objc func onPlayCompleted(noti: Notification) {
        //播放完成从数组中删除playingpath 并播放下一条数据
        self.contentsArr.removeFirst()
        self.playPCMFile(filePath: self.contentsArr.first)
    }

    /// 移除通知
    func removeObser() {
        NotificationCenter.default.removeObserver(self)
    }

}

/// 文件操作
extension NoteVedioPlayBLL {

    private func getDocumentsPath()->String {
        do {
            let documentPaths = try FileManager.default.url(for: FileManager.SearchPathDirectory.cachesDirectory,
                                                            in: FileManager.SearchPathDomainMask.userDomainMask,
                                                            appropriateFor: nil, create: true)
            let documentPath = documentPaths.absoluteString
            return documentPath.substringFromIndex(7)
        }catch{
            return ""
        }
    }


    private func getContentFromFolderDESC()->[String]{
        let dirPath = self.getDocumentsPath()
        var sortedFilePath:[String] = []
        do {
            let fileArr = try FileManager.default.contentsOfDirectory(atPath: dirPath)
            for eachItem in fileArr {
                if !eachItem.contains(contentPCMFileName) { continue }
                sortedFilePath.append(eachItem)
            }
            let resultFileArr = IIMergeSort.sort(array: sortedFilePath)
            return resultFileArr
        }catch {
            return []
        }
    }
}
