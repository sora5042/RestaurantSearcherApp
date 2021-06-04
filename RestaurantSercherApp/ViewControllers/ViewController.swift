//
//  ViewController.swift
//  RestaurantSercherApp
//
//  Created by 大谷空 on 2021/06/02.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       fetchShopDataInfo()
        
    }
    
    private func fetchShopDataInfo() {
        
        let urlString = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=a029724abd77ddd5&large_area=Z011&format=json"
        let request = AF.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default)
        
        request.responseJSON { (response) in
            
            do {
                guard let data = response.data else { return }
                let decode = JSONDecoder()
                let shop = try decode.decode(ShopData.self, from: data)
                print("shop: ", shop.results.shop.count)

            } catch let jsonError {
                print("jsonError: ", jsonError)
            }

        }.resume()
        
    }
}
