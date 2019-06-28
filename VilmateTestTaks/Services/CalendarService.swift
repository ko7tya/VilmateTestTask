//
//  CalendarService.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/26/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation
import EventKit

typealias CalendarResult = Result<[CalendarEvent], CalendarError>

protocol CalendarServiceType {
    func fetchEventsFromCalendar(completion:  @escaping (CalendarResult) -> Void)
    func getEvent(with id: String) -> CalendarEvent?
}

enum CalendarError: Error {
    case noAccess
}

class CalendarService {
    let eventStore = EKEventStore()

    private func requestAccessToCalendar(with completion: @escaping (CalendarResult) -> Void) {
        eventStore.requestAccess(to: EKEntityType.event) { [weak self] (accessGranted, error) in
            guard let self = self else {
                return
            }
            if accessGranted {
                self.getCalendars(with: completion)
            }else {
                completion(.failure(.noAccess))
            }
        }
    }
    
    private func getCalendars(with completion: (CalendarResult) -> Void) {
        let calendars = eventStore.calendars(for: .event)
        
        for calendar in calendars {
            if !Constsants.exclusionCalendarNames.contains(calendar.source.title) {
            let oneMonthAfter = Date(timeIntervalSinceNow: +30*24*3600)
            
            let predicate = eventStore.predicateForEvents(withStart: Date(), end: oneMonthAfter, calendars: [calendar])
            
            let events = eventStore.events(matching: predicate)
            
            let calendarEvents = events.map({
                CalendarEvent(with: $0)
            })
                completion(.success(calendarEvents))
            }
        }
    }   
}

extension CalendarService: CalendarServiceType {
    
    func fetchEventsFromCalendar(completion: @escaping (CalendarResult) -> Void) {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status) {
        case .notDetermined:
            requestAccessToCalendar(with: completion)
        case .authorized:
            getCalendars(with: completion)
        case .restricted, .denied: break
            
        @unknown default:
            break
        }
    }
    
    func cancelReminder(with id: String) {
        guard let event = eventStore.event(withIdentifier: id), let alarms = event.alarms else {
            return
        }
        for alarm in alarms {
            event.removeAlarm(alarm)
        }
    }
    
    func getEvent(with id: String) -> CalendarEvent?  {
        guard let event = eventStore.event(withIdentifier: id) else {
            return nil
        }
        return CalendarEvent(with: event)
    }
}
