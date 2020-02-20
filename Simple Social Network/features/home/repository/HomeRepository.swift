//
//  HomeRepository.swift
//  Simple Social Network
//
//  Created by Adriano Song on 20/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import RxSwift

class HomeRepository: AppRepository {
    
    func getPosts() -> Observable<Posts> {
        return BaseApi.request(urlConvertile: ApiRouter.getPosts)
    }
}
