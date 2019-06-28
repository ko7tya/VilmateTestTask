//
//  LocalNotificationService.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/26/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation
import UserNotifications

protocol LocalNotificationServiceProtocol {
    func scheduleNotification(from event: CalendarEvent)
    func removeNotification(for event: CalendarEvent)
    func start()
    func getPendingNotificationIds(completion: @escaping (([String]) -> ()))
    var userTapOnNotification: ((String) -> Void)? { get set}
}

class LocalNotificationService: NSObject {
    var userTapOnNotification: ((String) -> Void)?
    static let shared: LocalNotificationService = LocalNotificationService()
    private override init() {
        super.init()
    }
    let notificationCenter = UNUserNotificationCenter.current()
}

extension LocalNotificationService: LocalNotificationServiceProtocol {
    func start() {
        notificationCenter.delegate = self
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    func removeNotification(for event: CalendarEvent) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [event.id])
    }
    
    func scheduleNotification(from event: CalendarEvent) {
        guard event.shouldSendLocalPush else {
            return
        }
        
        let content = UNMutableNotificationContent()
        let categoryIdentifire = "Delete Notification Type"
        
        content.title = event.title
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = categoryIdentifire
        
        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: event.startDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        let identifier = event.id
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "DeleteAction", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: categoryIdentifire,
                                              actions: [snoozeAction, deleteAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
    func getPendingNotificationIds(completion: @escaping (([String]) -> ())) {
        notificationCenter.getPendingNotificationRequests { requests in
            completion(requests.map({$0.identifier}))
        }
    }
}

extension LocalNotificationService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let id = response.notification.request.identifier
        
        userTapOnNotification?(id)
        completionHandler()
    }
}
