//
//  APIRouter.swift
//  FightCorona
//
//  Created by Wai Shan on 2/4/20.
//  Copyright © 2020 Wai Shan. All rights reserved.
//

import Foundation
import Alamofire

enum UserEndpoint: APIConfiguration {
    
    case all
    case countries
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .all:
            return K.path.all
        case .countries:
            return K.path.countries
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    var isTokenRequire: Bool {
        switch self {
        default:
            return true
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.serverURL.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = parameters {
            do {
                urlRequest = try parameterEncoding.encode(urlRequest, with: parameters)
                return urlRequest
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
