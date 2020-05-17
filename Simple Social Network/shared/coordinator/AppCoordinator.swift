//
//  AppCoordinator.swift
//  Simple Social Network
//
//  Created by Adriano Song on 17/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI
import RxSwift

protocol AppCoordinatorDelegate: class {
    func finish(coordinator: CoordinatorKey)
}

class AppCoordinator: Coordinator, AppCoordinatorDelegate {
    
    let window: UIWindow?
    fileprivate let bag = DisposeBag()
        
    init(window: UIWindow?) {
        
        self.window = window
        
        bindUserSession()
    }

    fileprivate func bindUserSession() {
        //init the app singleton
        let app = App.shared

        //OBS: here needs to be a strong reference to AppCoordinator
        app.userSession.asObservable().subscribe { event in

            switch event.element {
            case .loggedIn:
                self.startHome()
            case .loggedOut:
                self.startWelcome()
            case .none:
                break
            }
        }.disposed(by: bag)
    }
    
    fileprivate func startWelcome() {
        let welcomeCoordinator = WelcomeCoordinator(window: self.window)
        welcomeCoordinator.start(delegate: self)
    }

    fileprivate func startHome() {
        let homeCoordinator = HomeCoordinator(window: self.window)
        homeCoordinator.start(delegate: self)
    }

    @available(*, deprecated,
    message: "now using Rx bindUserSession() method from AppCoordinator")
    func start(with: CoordinatorKey) {
        
        switch with {
        case .welcome:
            startWelcome()
        case .home:
            startHome()
        }
    }
    
    func finish(coordinator: CoordinatorKey) {
        
        switch coordinator {
        case .welcome:
            App.shared.userSession.accept(.loggedIn)
        case .home:
            App.shared.userSession.accept(.loggedOut)
        }
    }
}
