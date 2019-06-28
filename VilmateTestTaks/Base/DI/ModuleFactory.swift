//
//  ModuleFactory.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/27/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation

protocol ModuleFactory {
    func makeCalendarEventListViewController(with input: EventListInput) -> CalendarEventsListViewController
    func makeEventDetailViewController(with input: EventDetailModuleInput) -> EventDetailViewController
}

