//
//  HostingController.swift
//  Simple Social Network
//
//  Created by Adriano Song on 18/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

class WelcomeHostingController: UIHostingController<WelcomeView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class HomeHostingController: UIHostingController<HomeView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
