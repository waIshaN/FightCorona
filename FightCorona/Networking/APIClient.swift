//
//  APIClient.swift
//  FightCorona
//
//  Created by Wai Shan on 2/4/20.
//  Copyright © 2020 Wai Shan. All rights reserved.
//

import Alamofire
import PromiseKit

class APIClient {
    
    private static func performRequest<T: Decodable>(route: UserEndpoint, decoder: JSONDecoder = JSONDecoder()) -> Promise<T> {
        return Promise<T> { seal in
            AF.request(route)
            .responseJSON(completionHandler: { response in
                do {
                    guard let responseData = response.data else { return }
                    let decode = try JSONDecoder().decode(T.self, from: responseData)
                    seal.fulfill(decode)
                } catch {
                    seal.reject(error)
                }
            })
        }
    }
    
    static func FetchWorldStatus() -> Promise<WorldModel> {
        return performRequest(route: UserEndpoint.all)
    }
    
    static func FetchCountriesStatus() -> Promise<[CountryModel]> {
        return performRequest(route: UserEndpoint.countries)
    }
    
}
