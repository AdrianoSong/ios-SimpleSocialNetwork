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
        var contentView = WelcomeView(viewModel: WelcomViewModel())
        contentView.onFinish = {
            delegate?.finish(coordinator: .welcome)
        }

        self.window?.rootViewController = UIHostingController(rootView: contentView)
    }
}
