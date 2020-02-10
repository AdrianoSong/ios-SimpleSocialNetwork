//
//  AppRepository.swift
//  Simple Social Network
//
//  Created by Adriano Song on 10/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import Request

enum ApiPaths: String {
    case getToken = "/getToken"
    case getPosts = "/posts"
    case post = "/post"
    case user = "/user"
}

protocol AppRepository {
    
}

extension AppRepository {
    
    func getToken() {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "baseUrl") as? String else {
            return
        }
        
        let getTokenURLString = baseURL + ApiPaths.getToken.rawValue
        
        Request {
            Url(getTokenURLString)
            Method(.get)
            Header.ContentType(.json)
        }.onData({ data in
            let token = try? JSONDecoder().decode(Token.self, from: data)
            print("get token success \(token?.csrf)")
        }).onError({ error in
            print("get token failure \(error)")
        }).call()
    }
}
