//
//  DependencyContainer.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/27/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation


class DependencyContainer {
    
}

extension DependencyContainer: DependecyFactory {
    func makeLocalNotificationService() -> LocalNotificationServiceProtocol {
        return LocalNotificationService.shared
    }
    
    func makeCalendarService() -> CalendarServiceType {
        return CalendarService()
    }
}

extension DependencyContainer: ModuleFactory {
   
    func makeCalendarEventListViewController(with input: EventListInput) -> CalendarEventsListViewController {
        let vc: CalendarEventsListViewController = CalendarEventsListViewController.instantiate(storyboard: .main)
        let parent = input.parentCoordinator
        let router: RouterType = Router(navigationController: parent.router.navigationController)
        let coordinator = CalendarEventListCoordiantor(with: router, dependencies: DependencyContainer())
        let notificationService = makeLocalNotificationService()
        let calendarService = makeCalendarService()
        let viewModel = CalendarEventListViewModel(with: notificationService, calendarService: calendarService)
        vc.viewModel = viewModel
        vc.coordinator = coordinator
        return vc
    }
    
     func makeEventDetailViewController(with input: EventDetailModuleInput) -> EventDetailViewController {
        let vc: EventDetailViewController = EventDetailViewController.instantiate(storyboard: .main)
        let parentCoordinator = input.parentCoordinator
        let coordinator = EventDetailCoordinator(with: parentCoordinator.router,
                                                 dependencies: parentCoordinator.dependencies)
        let calendarService = makeCalendarService()
        let viewModel = EventDetailViewModel(with: calendarService)
        vc.viewModel = viewModel
        vc.coordinator = coordinator
        vc.eventId = input.eventId
        return vc
    }
}
