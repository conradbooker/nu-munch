//
//  Order.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import SwiftUI

struct OrderView: View {
    @State private var eateries: [String: Eatery] = [:]
    
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(areas, id: \.self) { area in
                        Text(area)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading, 12)
                            .padding(.bottom, 5)
                        ForEach(eateries.keys.sorted(), id: \.self) { eatery_key in
                            if eateries[eatery_key]?.area ?? "" == area {
                                NavigationLink {
                                    EateryView(eatery: eateries[eatery_key])
                                } label: {
                                    EateryRow(eatery: eateries[eatery_key])
                                        .environmentObject(locationManager)
                                }
                            }
                        }
                    }
                }
                
                .onAppear {
                    ApiCall().getAllEateries { result in
                        switch result {
                        case .success(let fetchedEateries):
                            var eateryDict: [String: Eatery] = [:]
                            fetchedEateries.forEach { eatery in
                                eateryDict[eatery.id] = eatery
                            }
                            self.eateries = eateryDict
                        case .failure(let error):
                            print("Failed to fetch eateries: \(error)")
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    @Previewable @StateObject var locationManager = LocationManager()

    OrderView()
        .environmentObject(locationManager)
}
