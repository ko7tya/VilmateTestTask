//
//  CalendarEvent.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/26/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation
import EventKit

struct CalendarEvent {
    let id: String
    let title: String
    let startDate: Date
    let endDate: Date
    let attendies: [Attendee]?
    let description: String?
    
    var isNotificationSet: Bool = false
    var shouldSendLocalPush:Bool = false

    init(with event: EKEvent) {
        id = event.eventIdentifier
        title = event.title
        startDate = event.startDate
        endDate = event.endDate
        description = event.notes
        attendies = event.attendees?.compactMap({
            Attendee(from: $0)
        })
        shouldSendLocalPush = attendies?.contains(where: { (attendee) -> Bool in
            return !attendee.email.isGmail()
        }) ?? false
    }
    
    
    
}
