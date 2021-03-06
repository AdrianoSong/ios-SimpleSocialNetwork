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
        
        guard let window = self.window else {
            return
        }
        
        let contentView = HomeView(viewModel: HomeViewModel())
        
        UIView.windowFlipTranstion(
            window: window, viewController: HomeHostingController(rootView: contentView))
    }
}
