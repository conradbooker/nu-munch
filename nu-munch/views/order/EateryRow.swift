//
//  EateryRow.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import SwiftUI
import CoreLocation

struct EateryRow: View {
    var eatery: Eatery?
    @EnvironmentObject private var locationManager: LocationManager
    
    func getDistance(from location: CLLocationCoordinate2D, to eateryLocationString: String) -> Double {
        let coordinates = eateryLocationString.split(separator: ",").map { Double($0.trimmingCharacters(in: .whitespaces)) }
        if let latitude = coordinates.first, let longitude = coordinates.last {
            let eateryLocation = CLLocation(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
            let userLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            return userLocation.distance(from: eateryLocation)
        }
        return 0.0
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 80)
                .foregroundColor(.gray.opacity(0.2))
                .shadow(radius: 4)
            
            HStack {
                // Image loaded directly from assets using the eatery's id.
                if let eatery = eatery {
                    Image(eatery.id)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 56, height: 56)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.leading, 12)
                }
                
                // Eatery details
                VStack(alignment: .leading) {
                    Text(eatery?.name ?? "")
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    if let userLocation = locationManager.lastKnownLocation, let eatery = eatery {
                        let distance = getDistance(from: userLocation, to: eatery.location)
                        Text("\(String(format: "%.2f", distance / 1000)) km away · Closes at 6pm")
                            .foregroundColor(.black)
                    } else {
                        Text("Unknown Distance · Closes at 6pm")
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.trailing, 12)
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 10)
    }
}

#Preview {
    @Previewable @StateObject var locationManager = LocationManager()
    EateryRow(eatery: defaultEateries["0"])
        .environmentObject(locationManager)
}

