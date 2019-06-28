//
//  BackgroundService.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/26/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation
import UIKit

protocol BackgroundTaskServiceType {
    func application(_ application: UIApplication,
                     performFetchWithCompletionHandler completionHandler:
        @escaping (UIBackgroundFetchResult) -> Void)
}

class BackgroundTaskService {
    
    let calendarService: CalendarServiceType
    let localNotificationService: LocalNotificationServiceProtocol
    static let minimumBackgroundFetchInterval: TimeInterval = 3600
    init(with calendarService: CalendarServiceType, localNotificationService: LocalNotificationServiceProtocol) {
        self.calendarService = calendarService
        self.localNotificationService = localNotificationService
        configuration()
    }
    
    func configuration() {
        UIApplication.shared.setMinimumBackgroundFetchInterval(BackgroundTaskService.minimumBackgroundFetchInterval)
    }
    
}

extension BackgroundTaskService: BackgroundTaskServiceType {
    func application(_ application: UIApplication,
                     performFetchWithCompletionHandler completionHandler:
        @escaping (UIBackgroundFetchResult) -> Void) {
        localNotificationService.getPendingNotificationIds { (ids) in
            var newData = false
            self.calendarService.fetchEventsFromCalendar(completion: { (result) in
                switch result {
                case .success(let events):
                    for event in events {
                        if !ids.contains(event.id) {
                            self.localNotificationService.scheduleNotification(from: event)
                            newData = true
                        }
                    }
                    completionHandler(newData ? .newData: .noData)
                case .failure:
                    completionHandler(.failed)
                }
            })
            
        }
    }
}


