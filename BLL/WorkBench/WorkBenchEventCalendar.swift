//
//  WorkBenchEventCalendar.swift
//  DingTalkCalander
//
//  Created by Noah_Shan on 2018/4/14.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
import EventKit

class WorkBenchEventCalendar: NSObject, IWorkBenchEventCalendar {

    var dal = DingTalkGetEventCalender()

    static let formatStr = "yyyy-MM-dd"

    /// get evente from calendar
    ///
    /// - Parameters:
    ///   - from: date
    ///   - to: date
    ///   - mainThreadAction: eventAction[in main thread]
    @objc func getEventsInGlobalQueue(from: Date, to: Date, mainThreadAction: @escaping (_ eventsArr: [EKEvent]) -> Void) {
        let result = OTNoteDAL().getDataFollowDate(startDate: from, endDate: to)
        mainThreadAction(result)
    }

    /// set event
    func setEvent(with: DingTalkCEvent, successAction:@escaping () -> Void, failAction:@escaping () -> Void) {
        let event: EKEvent = EKEvent(eventStore: dal.eventDB)
        event.title = with.title
        event.startDate = with.realStartTime.toDate("yyyy-MM-dd HH:mm")
        event.endDate = with.realEndTime.toDate("yyyy-MM-dd HH:mm")
        event.addAlarm(EKAlarm(relativeOffset: (-with.relativeOffset)))
        event.isAllDay = with.isAllDay
        dal.addEvents(with: event, successAction: successAction, failAction: failAction)
    }
}
