//
//  EventDetailModuleInput.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/28/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation


struct EventDetailModuleInput: ModuleInput {
    
    var parentCoordinator: CoordinatorType
    var eventId: String
    init(with parentCoordinator: CoordinatorType, eventId: String) {
        self.parentCoordinator = parentCoordinator
        self.eventId = eventId
    }
}
