//
//  Coordinator.swift
//  Simple Social Network
//
//  Created by Adriano Song on 17/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation

protocol Coordinator {
        
    func start(with: CoordinatorKey)
}

protocol ChildCoordinator: class {
    func start(delegate: AppCoordinatorDelegate?)
}
