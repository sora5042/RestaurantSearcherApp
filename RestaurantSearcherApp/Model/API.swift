//
//  API.swift
//  RestaurantSercherApp
//
//  Created by 大谷空 on 2021/06/03.
//

import Foundation
import Alamofire

class API {
    
    static let shared = API()
    
    private let baseUrl = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
    
    func request<T: Decodable>(params: [String: Any], type: T.Type, completion: @escaping (T) -> Void) {
        
        let url = baseUrl + "?"
        
        var params = params
        params["key"] = "a029724abd77ddd5"
        params["range"] = "5"
        params["count"] = "20"
        params["format"] = "json"
    
        let request = AF.request(url, method: .get, parameters: params)
        
        request.responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else { return }
            
            if statusCode <= 300 {
            
                do {
                   
                    guard let data = response.data else { return }
                    let decoder = JSONDecoder()
                    let value = try decoder.decode(T.self, from: data)
                    
                    completion(value)
                    
                } catch let jsonError {
                    print("jsonError: ", jsonError)
                }
            }
        }
    }
}
