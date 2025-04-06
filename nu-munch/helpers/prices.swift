//
//  prices.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import CoreLocation

func getPrice(location1: CLLocation, location2: CLLocation) -> Double {
    let distance = location1.distance(from: location2)
    let price = distance / 200.0
    return ceil(price)
}
