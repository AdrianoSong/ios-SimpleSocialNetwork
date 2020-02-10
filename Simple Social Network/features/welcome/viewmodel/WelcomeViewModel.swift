//
//  WelcomeViewModel.swift
//  Simple Social Network
//
//  Created by Adriano Song on 10/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation

class WelcomViewModel {
    
    let repository = WelcomeRepository()
    
    init() {
        //TODO: remove here after testing
        repository.getToken()
    }
}
