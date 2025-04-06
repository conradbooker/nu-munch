//
//  DeliverComponents.swift
//  nu-munch
//
//  Created by Daniel on 4/5/25.
//

import SwiftUI

struct DeliverView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Top section (Fran’s → Tech, price, time, café, closes)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 6) {
                            Text("Fran’s → Tech")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("$5")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        }
                        
                        // Include the time, café, and closing info here
                        Text("12 minutes • Café • Closes at 1am")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    
                    // Time Remaining (in red)
                    Text("Time Remaining")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text("45:00 minutes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.systemRed))
                        .padding(.horizontal)
                    
                    // Order Details
                    VStack(alignment: .leading, spacing: 6) {
                        Text("To: Jennifer Brown (312)-xxx-xxxx")
                        Text("Order: Chicken Tenders")
                        Text("Notes: get ketchup too")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    
                    // Action-like elements (non-interactive), stacked vertically
                    VStack(alignment: .center, spacing: 16) {
                        Text("Cancel (Unavailable)")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemRed))
                            .cornerRadius(8)
                        
                        Text("Delivered")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    // Footnote
                    Text("*If meal does not get delivered within 45 minutes of claiming the order, the buyer gets a refund. You can cancel within 10 minutes of claiming.")
                        .font(.footnote)
                        .foregroundColor(Color(.systemRed))
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    Spacer()
                }
                .padding(.top, 16)
            }
            .navigationTitle("Deliver")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DeliverView()
}

