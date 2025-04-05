//
//  model.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import Foundation

struct User: Hashable, Codable {
    let name: String
    let email: String
    let profilePhoto: String
    let currentDelivery: Order?
    let currentOrder
    let pastDeliv
}

struct Order: Hashable, Codable {
    let id: String
    let status: String
    let items: [Item]
    let locationStart: String
    let locationEnd: String
    let price: String
    let deliverer: Int
    let orderer: Int
}
