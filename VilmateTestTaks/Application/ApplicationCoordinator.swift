//
//  ApplicationCoordinator.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/27/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation
import UIKit
class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(with window: UIWindow, dependencies: DependencyContainer, router: RouterType) {
        self.window = window
        super.init(router: router, dependencies: dependencies)
    }
    
    func start() {
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
        let input = EventListInput(with: self)
        let vc = dependencies.makeCalendarEventListViewController(with: input)
        router.push(vc, animated: true)
    }
    
}
