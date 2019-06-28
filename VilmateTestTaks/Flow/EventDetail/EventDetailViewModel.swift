//
//  EventDetailViewModel.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/28/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation

protocol EventDetailViewModelType {
    func getEvent(with id: String) -> CalendarEvent?
}

class EventDetailViewModel: ViewModelType {
    let calendarService: CalendarServiceType
    init(with calendarService: CalendarServiceType) {
        self.calendarService = calendarService
    }
}

extension EventDetailViewModel: EventDetailViewModelType {
    func getEvent(with id: String) -> CalendarEvent? {
        return calendarService.getEvent(with: id)
    }
}
