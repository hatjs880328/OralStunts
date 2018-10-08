//
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// AOPGCDExtension.swift
//
// Created by    Noah Shan on 2018/3/15
// InspurEmail   shanwzh@inspur.com
// GithubAddress https://github.com/hatjs880328s
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// For the full copyright and license information, plz view the LICENSE(open source)
// File that was distributed with this source code.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
//

import Foundation

/**
 task lvl enum
 
 - HighLevel:     high
 - NormalLevel:   normal
 - LowLevel:      low
 - VeryHighLevel: v-high
 */
enum PriorityLevel {
    case highLevel, normalLevel, lowLevel, veryHighLevel
}

///  background progres tasks √
///  parameters save current task count √
///  progress one task & remove it √
///  add one task & sort task arr  √
///  interrupt the task manager
///  interrupt the executing task
///  remove the task who has no executed
///  ...
///  set task lvl √

class IISlinkManager {

    /// if progress task now
    var ifprogressNow = false

    /// recursive-lock
    let recurLock = NSRecursiveLock()

    /// task - arr
    var tastArr: Array<IITaskModel> = []

    init(linkname: String) {

    }

    /**
     start - execute
     */
    private func exeAllfunction() {
        GCDUtils.asyncProgress(dispatchLevel: 1, asyncDispathchFunc: {
            while true {
                self.recurLock.lock()
                if self.tastArr.count != 0 {
                    //DEBUGPrintLog("\(self.TASK_ARRAY[0].taskname!)start-execute")
                    self.tastArr[0].exeFunc()
                    self.removeOnetask(index: 0)
                    self.recurLock.unlock()
                    continue
                } else {
                    self.recurLock.unlock()
                    self.ifprogressNow = false
                    return
                }
            }
        }) { 
        }
    }

    /**
     add one task - then [sort the tasks]
     
     - parameter task: task
     */
    func addTask(task: IITaskModel) {
        self.recurLock.lock()
        self.tastArr.append(task)
        self.tastArr = IIMergeSort.sort(array: self.tastArr)
        //DEBUGPrintLog("\(task.taskname!)add over & sort over")
        self.recurLock.unlock()
        if !ifprogressNow {
            ifprogressNow = true
            exeAllfunction()
        }
    }

    /**
     remove a task
     
     - parameter Index: task index in task - arr
     */
    func removeOnetask(index: Int) {
        if index == 0 {
            self.tastArr.removeFirst()
        }
    }

    /**
     set task lvl default is lvl 1
     
     - parameter level   : lvl
     - parameter taskName: task name (uuid)
     */
    func setPriorityLevel(level: Int, taskName: String = "") {
        self.recurLock.lock()
        for (item, _) in self.tastArr.enumerated() {
            if tastArr[item].taskname == taskName {
                let task = tastArr[item]
                self.tastArr.insert(task, at: 0)
                self.tastArr.remove(at: item + 1)
                break
            }
        }
        self.recurLock.unlock()
    }
}
