//
//  DeliverView.swift
//  nu-munch
//
//  Created by Daniel Wu on 4/6/25.
//

import SwiftUI

struct Delivery: Identifiable {
    let id = UUID()
    let from: String
    let to: String
    let expiresMinutes: Int
    let timeNeeded: Int
    let cuisine: String
    let closingTime: String
    let cost: Int
}

struct DeliverView: View {

    let deliveries: [Delivery] = [
        Delivery(from: "Fran’s",      to: "Tech",
                 expiresMinutes: 5,  timeNeeded: 12,
                 cuisine: "Café",    closingTime: "1am",
                 cost: 5),
        Delivery(from: "Lisa’s",      to: "Allison",
                 expiresMinutes: 10, timeNeeded: 5,
                 cuisine: "Mexican", closingTime: "1am",
                 cost: 5),
        Delivery(from: "Shakesmart",  to: "Mudd",
                 expiresMinutes: 1,  timeNeeded: 11,
                 cuisine: "Shakes",  closingTime: "6pm",
                 cost: 15)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(deliveries) { delivery in
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue)
                            .frame(height: 80)
                            .shadow(radius: 4)

                        HStack {
                            VStack(alignment: .leading, spacing: 4) {

                                HStack {
                                    Text("\(delivery.from) → \(delivery.to)")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("\(delivery.timeNeeded) minutes")
                                    Text("· \(delivery.cuisine)")
                                    Text("· Closes at \(delivery.closingTime)")
                                }
                                .font(.subheadline)
                                .foregroundColor(.black)
                                
                                HStack {
                                    Text("$\(delivery.cost)")
                                        .font(.headline)
                                        .foregroundColor(.green)
                                    Spacer()
                                    
                                    Text("expires: \(delivery.expiresMinutes) min")
                                        .font(.headline)
                                        .foregroundColor(.red)
                                    
                                }
                            }
                            .padding(.leading, 12)
                            
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                                .padding(.trailing, 12)
                        }
                    }
                    .padding(.horizontal, 12)
                }
            }
            .padding(.top, 16)
        }
    }
}

#Preview {
    DeliverView()
}

