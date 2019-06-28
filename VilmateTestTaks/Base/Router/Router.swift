//
//  Router.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/27/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation
import UIKit

public protocol RouterType: AnyObject {
    var navigationController: UINavigationController { get }
    func push(_ vc: UIViewController, animated: Bool)
}

class Router: RouterType {
    
    var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController)  {
        self.navigationController = navigationController
    }
    
    func push(_ vc: UIViewController, animated: Bool) {
        navigationController.pushViewController(vc, animated: animated)
    }
}
