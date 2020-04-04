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
        return BaseApi.request(urlConvertile: ApiRouterV2.getPosts)
    }
    
    func createPost(title: String, postDescription: String, userId: Int?) -> Observable<Post> {
        return BaseApi.request(urlConvertile: ApiRouterV2.createPost(
            title: title, postDescription: postDescription, userId: userId))
    }
}
