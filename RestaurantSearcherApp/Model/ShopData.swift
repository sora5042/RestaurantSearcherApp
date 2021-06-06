//
//  Shop.swift
//  RestaurantSercherApp
//
//  Created by 大谷空 on 2021/06/03.
//

import Foundation

class ShopData: Decodable {
    
    let results: Result
}

class Result: Decodable {
    
    let shop: [Shop]
}

class Shop: Decodable {
    
    let access: String
    let address: String
    let name: String
    let open: String
    let parking: String
    let photo: Photo
}

class Photo: Decodable {
    
    let mobile: Mobile
}

class Mobile: Decodable {
    
    let l: String
}
