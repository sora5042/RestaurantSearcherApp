//
//  API.swift
//  RestaurantSercherApp
//
//  Created by 大谷空 on 2021/06/03.
//

import Foundation
import Alamofire

class API {
    
    static var shared = API()
    
    private let baseUrl = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
    
    func request<T: Decodable>(params: [String: Any], idoValue: String, keidoValue: String, type: T.Type, completion: @escaping (T) -> Void) {
        
        let url = baseUrl + "?"
        var params = params
        params["key"] = "a029724abd77ddd5"
        params["lat"] = idoValue
        params["lng"] = keidoValue
        params["range"] = "3"
        params["format"] = "json"
        
        let request = AF.request(url, method: .get, parameters: params)
        
        request.responseJSON { (response) in
            
            do {
                guard let data = response.data else { return }
                let decode = JSONDecoder()
                let value = try decode.decode(T.self, from: data)
                
                completion(value)
                
            } catch let jsonError {
                print("jsonError: ", jsonError)
            }
        }
    }
}
