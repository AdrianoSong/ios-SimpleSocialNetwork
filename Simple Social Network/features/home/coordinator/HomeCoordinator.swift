//
//  HomeCoordinator.swift
//  Simple Social Network
//
//  Created by Adriano Song on 17/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

class HomeCoordinator: ChildCoordinator {

    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start(delegate: AppCoordinatorDelegate?) {
        
        let contentView = HomeView()
        
        guard let window = self.window else {
            return
        }
        
        UIView.windowFlipTranstion(
            window: window, viewController: UIHostingController(rootView: contentView))
    }
}
