//
//  AppModel.swift
//  Simple Social Network
//
//  Created by Adriano Song on 10/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation

typealias User = [UserElement]

struct UserElement: Codable {
    let posts: [Post]?
    let createdAt, updatedAt: String?
    let id: Int?
    let name, email, password: String?
}

struct Post: Codable {
    let createdAt, updatedAt: String?
    let id: Int?
    let title, body: String?
    let postOwner: UserElement?
}

struct Token: Codable {
    let csrf: String?

    enum CodingKeys: String, CodingKey {
        case csrf = "_csrf"
    }
}
