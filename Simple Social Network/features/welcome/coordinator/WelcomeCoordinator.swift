//
//  WelcomeCoordinator.swift
//  Simple Social Network
//
//  Created by Adriano Song on 17/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

class WelcomeCoordinator: ChildCoordinator {

    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start(delegate: AppCoordinatorDelegate?) {
        
        guard let window = self.window else {
            return
        }
        
        let contentView = WelcomeView(viewModel: WelcomViewModel())

        UIView.windowFlipTranstion(
            window: window,
            flipTranstion: .right,
            viewController: WelcomeHostingController(rootView: contentView)
        )
    }
}
