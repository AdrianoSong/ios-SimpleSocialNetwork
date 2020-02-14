//
//  CreateAccountRepository.swift
//  Simple Social Network
//
//  Created by Adriano Song on 14/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import RxSwift

class CreateAccountRepository: AppRepository {
    
    func createUser(name: String, email: String, password: String) -> Observable<UserElement> {
        return BaseApi.request(
            urlConvertile: ApiRouter.createUser(name: name, email: email, password: password))
    }
}
