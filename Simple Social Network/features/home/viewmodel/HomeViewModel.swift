//
//  HomeViewController.swift
//  Simple Social Network
//
//  Created by Adriano Song on 20/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import RxSwift
import SwiftUI

class HomeViewModel: ObservableObject {

    let bag: DisposeBag
    let repository: HomeRepository
    @Published var posts = Posts()
    
    init() {
        bag = DisposeBag()
        repository = HomeRepository()
    }
    
    func getPosts() -> Observable<Posts> {
        return repository.getPosts()
    }
    
    func createPost(title: String, postDescription: String, userId: Int?) -> Observable<Post> {
        return repository.createPost(title: title, postDescription: postDescription, userId: userId)
    }
}
