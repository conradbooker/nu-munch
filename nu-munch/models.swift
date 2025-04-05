//
//  model.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import Foundation

struct User: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let profilePhoto: String
    
    // order ids
    let currentDelivery: Int
    let currentOrder: Int
    let pastDeliveries: [Int]
}

struct Order: Hashable, Codable, Identifiable {
    let id: Int
    let status: String
    let foodItem: [FoodItem]
    let locationStart: String
    let locationEnd: String
    let price: Double
    
    // deliverer and orderer ids
    let deliverer: Int
    let orderer: Int
}

struct FoodItem: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let contents: [String]
    let eatery_id: Int
    let price: Double
    let photo: String
}

struct Eatery: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let photo: String
    let location: String
}
