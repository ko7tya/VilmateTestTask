//
//  CalendarListViewModel.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/27/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation


protocol CalendarEventListViewModelType {
    func fetchEventsFromCalendar(completion:  @escaping (CalendarResult) -> Void)
    func scheduleNotification(from event: CalendarEvent)
    func removeNotification(for event: CalendarEvent)
    func getPendingNotificationIds(completion: @escaping (([String]) -> ()))
    func getEvent(with id: String) -> CalendarEvent?
    var userTapOnNotification: ((String) -> Void)? { get set }
}

class CalendarEventListViewModel: ViewModelType {
    var localNotificationService: LocalNotificationServiceProtocol
    let calendarService: CalendarServiceType
    var userTapOnNotification: ((String) -> Void)?

    init(with localNotificationService: LocalNotificationServiceProtocol, calendarService: CalendarServiceType){
        self.localNotificationService = localNotificationService
        self.calendarService = calendarService
        setupBindings()
    }
    
    func setupBindings() {
        localNotificationService.userTapOnNotification = { [weak self] id in
            guard let self = self else { return }
            self.userTapOnNotification?(id)
        }
    }
}

extension CalendarEventListViewModel: CalendarEventListViewModelType {
    func fetchEventsFromCalendar(completion: @escaping (CalendarResult) -> Void) {
        calendarService.fetchEventsFromCalendar(completion: completion)
    }
    
    func scheduleNotification(from event: CalendarEvent) {
        localNotificationService.scheduleNotification(from: event)
    }
    
    func removeNotification(for event: CalendarEvent) {
        localNotificationService.removeNotification(for: event)
    }
    
    func getPendingNotificationIds(completion: @escaping (([String]) -> ())) {
        localNotificationService.getPendingNotificationIds(completion: completion)
    }
    
    func getEvent(with id: String) -> CalendarEvent? {
        return calendarService.getEvent(with: id)
    }
}
