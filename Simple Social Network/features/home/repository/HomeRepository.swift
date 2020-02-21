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
    
    func createPost(title: String, postDescription: String, userId: Int?) -> Observable<Post> {
        return BaseApi.request(urlConvertile: ApiRouter.createPost(
            title: title, postDescription: postDescription, userId: userId))
    }
}
