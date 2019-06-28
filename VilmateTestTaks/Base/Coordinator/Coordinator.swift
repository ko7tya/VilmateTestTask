//
//  Coordinator.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/27/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation

protocol CoordinatorType {
    var router: RouterType { get }
    var dependencies: DependencyContainer { get }
}

open class Coordinator: NSObject, CoordinatorType {
    
    public var childCoordinators: [Coordinator] = []
    
     var router: RouterType
    var dependencies: DependencyContainer
    
    init(router: RouterType, dependencies: DependencyContainer) {
        self.router = router
        self.dependencies = dependencies
        super.init()
    }
    
    public func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    public func removeChild(_ coordinator: Coordinator?) {
        if let coordinator = coordinator, let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }
}
