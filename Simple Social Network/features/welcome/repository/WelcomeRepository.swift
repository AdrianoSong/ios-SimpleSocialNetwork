//
//  WelcomeRepository.swift
//  Simple Social Network
//
//  Created by Adriano Song on 10/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import RxSwift

class WelcomeRepository: AppRepository {
    
    func getUser(email: String, password: String) -> Observable<UserElement> {
        return BaseApi.request(urlConvertile: ApiRouterV2.getUser(email: email, password: password))
    }
}
