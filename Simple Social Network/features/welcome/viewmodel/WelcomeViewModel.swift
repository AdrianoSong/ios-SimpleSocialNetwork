//
//  WelcomeViewModel.swift
//  Simple Social Network
//
//  Created by Adriano Song on 10/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import RxSwift

class WelcomViewModel {
    
    let bag: DisposeBag
    let repository: WelcomeRepository
    
    init() {
        bag = DisposeBag()
        repository = WelcomeRepository()
    }
    
    func performLogin(email: String, password: String) -> Observable<UserElement> {
        
        return repository.getUser(email: email, password: password)
    }
}
