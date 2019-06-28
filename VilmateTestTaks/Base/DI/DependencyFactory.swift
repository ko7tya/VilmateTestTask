//
//  DependencyFactory.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/27/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation

protocol DependecyFactory {
    func makeLocalNotificationService() -> LocalNotificationServiceProtocol
    func makeCalendarService() -> CalendarServiceType
}
