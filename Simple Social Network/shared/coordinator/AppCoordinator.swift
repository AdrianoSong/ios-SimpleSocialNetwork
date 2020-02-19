//
//  AppCoordinator.swift
//  Simple Social Network
//
//  Created by Adriano Song on 17/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

protocol AppCoordinatorDelegate: class {
    func finish(coordinator: CoordinatorKey)
}

class AppCoordinator: Coordinator, AppCoordinatorDelegate {
    
    let window: UIWindow?
        
    init(window: UIWindow?) {
        
        self.window = window
        
        //init the app singleton
        _ = App.shared
    }
    
    func start(with: CoordinatorKey) {
        
        switch with {
        case .welcome:
            let welcomeCoordinator = WelcomeCoordinator(window: self.window)
            welcomeCoordinator.start(delegate: self)
            
        case .home:
            let homeCoordinator = HomeCoordinator(window: self.window)
            homeCoordinator.start(delegate: self)
        }
    }
    
    func finish(coordinator: CoordinatorKey) {
        
        switch coordinator {
        case .welcome:
            start(with: .home)
        case .home:
            start(with: .welcome)
        }
    }
}
