//
//  ActiveItem.swift
//  nu-munch
//
//  Created by Conrad on 4/6/25.
//

import Foundation
import SwiftUI
import CoreLocation

struct ActiveItem: View {
    @State private var deliveries: [String: Order] = [:]
    @EnvironmentObject private var locationManager: LocationManager
    
    @State private var showAlert: Bool = false
    
    @State private var State_delivery_key: String?
    
    func getDistance(from location: CLLocationCoordinate2D, to targetLocationString: String) -> Double {
        let coordinates = targetLocationString.split(separator: ",").map { Double($0.trimmingCharacters(in: .whitespaces)) }
        if let latitude = coordinates.first, let longitude = coordinates.last {
            let targetLocation = CLLocation(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
            let userLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            return userLocation.distance(from: targetLocation)
        }
        return 0.0
    }
    
    func calculateMinutes(distance: Double) -> Int {
        return Int(distance / 100)
    }
    
    @AppStorage("user_id") var user_id = "0"

    
    var body: some View {
            VStack(spacing: 10) {
                ForEach(deliveries.keys.sorted(), id: \.self) { delivery_key in
                    if deliveries[delivery_key]?.orderer ?? "" == user_id && deliveries[delivery_key]?.status != "Completed" {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .frame(height: 120)
                                .shadow(radius: 4)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text("\(deliveries[delivery_key]?.locationStart_description ?? "") → \(deliveries[delivery_key]?.locationEnd_description ?? "")")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                    }
                                    VStack {
                                        if let userLocation = locationManager.lastKnownLocation,
                                           let startLocation = deliveries[delivery_key]?.locationStart {
                                            let distance = getDistance(from: userLocation, to: startLocation)
                                            let minutes = calculateMinutes(distance: distance)
                                            Text("You are \(minutes) minutes from \(deliveries[delivery_key]?.locationStart_description ?? "")")
                                                .foregroundColor(.black)
                                            Text("\(Int(deliveries[delivery_key]?.price ?? 0) * 2) min delivery time")
                                        }
                                    }
                                    Spacer().frame(height: 10)
                                    
                                    HStack {
                                        Text("$\(Int(deliveries[delivery_key]?.price ?? 0))")
                                            .font(.headline)
                                            .foregroundColor(.green)
                                        Spacer()
                                        
                                        if let expiration = deliveries[delivery_key]?.expiration {
                                            let currentTime = Int(Date().timeIntervalSince1970)
                                            let minutesLeft = max((expiration - currentTime) / 60, 0)
                                            Text("expires: \(minutesLeft) min")
                                                .font(.headline)
                                                .foregroundColor(.red)
                                        } else {
                                            Text("expires: 0 min")
                                                .font(.headline)
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                                .padding(.leading, 12)
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                                    .padding(.trailing, 12)
                            }
                        }
                        .padding(.horizontal, 12)
                        .onTapGesture {
                            showAlert = true
                            State_delivery_key = delivery_key
                        }
                    }
                }
            }
            .padding(.top, 16)
        .onAppear {
            ApiCall().getAllOrders { result in
                switch result {
                case .success(let fetchedOrders):
                    self.deliveries = fetchedOrders.feedback
                case .failure(let error):
                    print("Failed to fetch orders: \(error)")
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Confirm Delivery"),
                message: Text("Do you want to take on this order?"),
                primaryButton: .default(Text("Yes")) {
                    if var order = deliveries[State_delivery_key ?? ""] {
                        let newOrder = Order(
                            id: order.id,
                            status: "Completed",
                            foodItem_id: order.foodItem_id,
                            locationStart: order.locationStart,
                            locationEnd: order.locationEnd,
                            locationStart_description: order.locationStart_description,
                            locationEnd_description: order.locationEnd_description,
                            price: order.price,
                            deliverer: user_id,
                            orderer: order.orderer,
                            expiration: order.expiration
                        )
                        ApiCall().updateOrder(order: newOrder) { result in
                            switch result {
                            case .success(let updatedOrder):
                                print("Order updated: \(updatedOrder)")
                            case .failure(let error):
                                print("Failed to update order: \(error)")
                            }
                            ApiCall().getAllOrders { result in
                                switch result {
                                case .success(let fetchedOrders):
                                    self.deliveries = fetchedOrders.feedback
                                case .failure(let error):
                                    print("Failed to fetch orders: \(error)")
                                }
                            }
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}


#Preview {
    @Previewable @StateObject var locationManager = LocationManager()
    
    ActiveItem()
        .environmentObject(locationManager)
}
