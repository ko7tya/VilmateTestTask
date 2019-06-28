//
//  EventDetailCoordinator.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/28/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation

protocol EventDetailCoordinatorType {
    
}

class EventDetailCoordinator: CoordinatorType {
    var router: RouterType
    var dependencies: DependencyContainer
    init(with router: RouterType, dependencies: DependencyContainer) {
        self.router = router
        self.dependencies = dependencies
    }
}

extension EventDetailCoordinator: EventDetailCoordinatorType {
    
}
