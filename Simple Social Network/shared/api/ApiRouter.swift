//
//  ApiRouter.swift
//  Simple Social Network
//
//  Created by Adriano Song on 11/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiRouterProtocol: URLRequestConvertible {
    var path: String { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }

    func asURLRequest() throws -> URLRequest
}

//The header fields
enum HttpHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case csrfTokem = "X-CSRF-Token"
}

//The content type (JSON)
enum ContentType: String {
    case json = "application/json"
    case xWwwFormUrlEncoded = "application/x-www-form-urlencoded"
}

///You can Create specific ApiRouter (ex: User) each one needs to conform ApiRouterProtocol
enum ApiRouterV2: ApiRouterProtocol {

    // MARK: - Endpoints
    case getToken
    case getUser (email: String, password: String)
    case createUser (name: String, email: String, password: String)
    case getPosts
    case createPost (title: String, postDescription: String, userId: Int?)

    var path: String {
        switch self {
        case .getToken:
            return "/getToken"

        case .getUser:
            return "/user"

        case .createUser:
            return "/createUser"

        case .getPosts:
            return "/posts"

        case .createPost:
            return "/post"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getToken:
            return nil

        case .getUser(let email, let password):
            return ["email": email, "password": password]

        case .createUser(let name, let email, let password):
            return ["name": name, "email": email, "password": password]

        case .getPosts:
            return nil

        case .createPost(let title, let postDescription, let userId):
            return ["title": title, "postDescription": postDescription, "userId": userId as Any]
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getToken:
            return .get
        case .getUser:
            return .post
        case .createUser:
            return .post
        case .getPosts:
            return .get
        case .createPost:
            return .post
        }
    }

    func asURLRequest() throws -> URLRequest {
        guard let baseUrl =
            try (Bundle.main.object(forInfoDictionaryKey: "baseUrl") as? String)?.asURL() else {
                throw AlamoError.invalidURL
        }

        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(path))

        urlRequest.httpMethod = method.rawValue

        setRequestHeaders(&urlRequest)

        let enconding: ParameterEncoding = {
            return getParameterEncoding()
        }()

        return try enconding.encode(urlRequest, with: parameters)
    }

    fileprivate func setRequestHeaders(_ urlRequest: inout URLRequest) {

        switch self {
        case .getUser, .createUser, .createPost:
            urlRequest.setValue(ContentType.xWwwFormUrlEncoded.rawValue,
                                forHTTPHeaderField: HttpHeaderField.contentType.rawValue)
            urlRequest.setValue(App.shared.token?.csrf ?? "",
                                forHTTPHeaderField: HttpHeaderField.csrfTokem.rawValue)

        default:
            urlRequest.setValue(ContentType.json.rawValue,
                                forHTTPHeaderField: HttpHeaderField.acceptType.rawValue)
            urlRequest.setValue(ContentType.json.rawValue,
                                forHTTPHeaderField: HttpHeaderField.contentType.rawValue)
        }
    }

    fileprivate func getParameterEncoding() -> ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        case .post:
            return URLEncoding.httpBody
        default:
            return JSONEncoding.default
        }
    }
}
