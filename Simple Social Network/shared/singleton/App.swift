//
//  App.swift
//  Simple Social Network
//
//  Created by Adriano Song on 11/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import RxSwift

class App : AppRepository {
    
    static let shared = App()
    
    let bag = DisposeBag()
    
    var token: Token?
    
    fileprivate init() {
        getToken()
            .retry(3)
            .subscribe(onNext: { token in
                self.token = token
            }, onError: { error in
                print("On to fetch token \(error)")
            }, onCompleted: {}
        ).disposed(by: bag)
    }
}
