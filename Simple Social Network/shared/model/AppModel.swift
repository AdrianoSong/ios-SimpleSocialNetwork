//
//  AppModel.swift
//  Simple Social Network
//
//  Created by Adriano Song on 10/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation

typealias User = [UserElement]
typealias Posts = [Post]

struct UserElement: Codable {
    let posts: [Post]?
    let createdAt, updatedAt: String?
    let id: Int?
    let name, email, password: String?
}

struct Post: Codable, Identifiable {
    let createdAt, updatedAt: String?
    let id, postOwner: Int?
    let title, body: String?
}

struct Token: Codable {
    let csrf: String?

    enum CodingKeys: String, CodingKey {
        case csrf = "_csrf"
    }
}
