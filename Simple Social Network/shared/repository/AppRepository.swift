//
//  AppRepository.swift
//  Simple Social Network
//
//  Created by Adriano Song on 10/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import RxSwift

protocol AppRepository {
    
    func getToken() -> Observable<Token>
}

extension AppRepository {
    
    func getToken() -> Observable<Token> {
        return BaseApi.request(urlConvertile: ApiRouterV2.getToken)
    }
}
