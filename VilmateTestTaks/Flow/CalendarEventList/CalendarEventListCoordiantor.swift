//
//  CalendarEventListCoordiantor.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/27/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation

protocol CalendarEventListCoordinatorType {
     func showDetail(with event: CalendarEvent)
}

class CalendarEventListCoordiantor: CoordinatorType {
    var router: RouterType
    var dependencies: DependencyContainer
    init(with router: RouterType, dependencies: DependencyContainer) {
        self.router = router
        self.dependencies = dependencies
    }
}

extension CalendarEventListCoordiantor: CalendarEventListCoordinatorType {
    func showDetail(with event: CalendarEvent) {
        let input = EventDetailModuleInput(with: self,
                                           eventId: event.id)
        let vc = dependencies.makeEventDetailViewController(with: input)
        router.push(vc, animated: true)
    }
}
