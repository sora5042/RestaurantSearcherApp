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
    let `catch`: String
    let lat: Double
    let lng: Double
    let name: String
    let open: String
    let parking: String
    let photo: Photo
}

class Photo: Decodable {
    
    let mobile: Mobile
    let pc: PC
}

class Mobile: Decodable {
    
    let l: String
    let s: String
}

class PC: Decodable {
    
    let l: String
    let s: String
    
}
