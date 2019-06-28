//
//  EventListInput.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/28/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation

struct EventListInput: ModuleInput {
    let parentCoordinator: CoordinatorType
    init(with parent: CoordinatorType) {
        parentCoordinator = parent
    }
}
