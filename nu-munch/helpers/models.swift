//
//  model.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import Foundation

struct User: Hashable, Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    
    // order ids
    let currentDelivery: String
    let currentOrder: String
    let pastDeliveries: [String]
    
    let currentBalance: Int
    let totalBalance: Int
}

struct Order: Hashable, Codable, Identifiable {
    let id: String
    let status: String
    let foodItem_id: String
    let locationStart: String
    let locationEnd: String
    
    let locationStart_description: String
    let locationEnd_description: String
    
    let price: Double
    
    // deliverer and orderer ids
    let deliverer: String
    let orderer: String
    
    let expiration: Int // time stamp
}

struct FoodItem: Hashable, Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let options: [String]
    let eatery_id: String
}

class FoodItemStorage {
    private let key = "storedFoodItem"
    
    func save(foodItem: FoodItem) {
        if let encoded = try? JSONEncoder().encode(foodItem) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func load() -> FoodItem? {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode(FoodItem.self, from: savedData) {
            return decoded
        }
        return nil
    }
    
    func delete() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

struct Eatery: Hashable, Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let location: String
    let area: String
}


let defaultEateries: [String: Eatery] = [
    "0": Eatery(id: "0", name: "Lisa", description: "hello", location: "42.06024, -87.67573", area: "North Area"),
    "1": Eatery(id: "1", name: "Tech Local", description: "hello", location: "42.05806, -87.67584", area: "North Area"),
    "2": Eatery(id: "2", name: "Buenos Dias", description: "hello", location: "42.05335, -87.67259", area: "Norris"),
    "3": Eatery(id: "3", name: "MOLD Pizza", description: "hello", location: "42.05335, -87.67259", area: "Norris"),
    "4": Eatery(id: "4", name: "123 Boirger", description: "hello", location: "42.05335, -87.67259", area: "Norris"),
    "5": Eatery(id: "5", name: "Fran", description: "hello", location: "42.05183, 87.68116", area: "South Area"),
]

let defaultFoodItems: [String: FoodItem] = [
    "0": FoodItem(id: "0", name: "Quesadillia", description: "Includes a Pizza... Please specify toppings below, and please specify if you want a water/etc in the description.", options: ["Cheese", "Meat"], eatery_id: "0"),
    "1": FoodItem(id: "1", name: "Taco", description: "This is a description", options: ["Cheese", "Meat"], eatery_id: "0"),
    "2": FoodItem(id: "2", name: "Burrito", description: "This is a description", options: ["Cheese", "Meat", "Beans", "Water"], eatery_id: "0"),
]

let areas: [String] = ["North Area", "Norris", "South Area"]


// class api key

