//
//  AppDelegate.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/26/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var applicationCoordinator: ApplicationCoordinator?

    let localNotificationService: LocalNotificationServiceProtocol = LocalNotificationService.shared
    let backgroundService: BackgroundTaskServiceType = BackgroundTaskService(with: CalendarService(), localNotificationService: LocalNotificationService.shared)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        

        let window = UIWindow(frame: UIScreen.main.bounds)
        let dependencies = DependencyContainer()
        let router = Router(navigationController: UINavigationController())
        let applicationCoordinator = ApplicationCoordinator(with: window,
                                                            dependencies: dependencies, router: router)
        self.window = window
        self.applicationCoordinator = applicationCoordinator
        
        applicationCoordinator.start()
        localNotificationService.start()
        
        return true
    }

    func application(_ application: UIApplication,
                     performFetchWithCompletionHandler completionHandler:
        @escaping (UIBackgroundFetchResult) -> Void) {
        backgroundService.application(application, performFetchWithCompletionHandler: completionHandler)
    }
    
}

