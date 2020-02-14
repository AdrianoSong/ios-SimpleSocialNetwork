//
//  ApiRouter.swift
//  Simple Social Network
//
//  Created by Adriano Song on 11/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    // MARK: - Endpoints
    case getToken
    case getUser (email: String, password: String)
    case createUser (name: String, email: String, password: String)
    
    // MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    fileprivate var parameters: Parameters? {
        switch self {
        case .getToken:
            return nil
            
        case .getUser(let email, let password):
            return ["email": email, "password": password]
            
        case .createUser(let name, let email, let password):
            return ["name": name, "email": email, "password": password]
            
        }
    }
    
    // MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    fileprivate var method: HTTPMethod {
        switch self {
        case .getToken:
            return .get
        case .getUser:
            return .post
        case .createUser:
            return .post
        }
    }
    
    fileprivate var path: String {
        switch self {
        case .getToken:
            return "/getToken"
            
        case .getUser:
            return "/user"
            
        case .createUser:
            return "/createUser"
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
        case .getUser, .createUser:
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
