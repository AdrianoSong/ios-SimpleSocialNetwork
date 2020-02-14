//
//  CreateAccountViewModel.swift
//  Simple Social Network
//
//  Created by Adriano Song on 14/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import RxSwift

class CreateAccountViewModel {
    
    let bag: DisposeBag
    
    let repository: CreateAccountRepository
    
    init() {
        bag = DisposeBag()
        repository = CreateAccountRepository()
    }
    
    func performCreateUser(name: String, email: String, password: String) -> Observable<UserElement> {
        return repository.createUser(name: name, email: email, password: password)
    }
}
