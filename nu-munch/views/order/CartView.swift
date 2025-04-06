import SwiftUI
import CoreLocation

struct CartView: View {
    @Binding var showCart: Bool
    @State private var cartItems: [FoodItem] = []
    @State private var showAlert: Bool = false
    @State private var itemToDelete: FoodItem?
    
    @EnvironmentObject private var locationManager: LocationManager
    
    func getEateryById(_ id: Int) -> String {
        if defaultEateries.keys.contains(String(id)) {
            return defaultEateries[String(id)]?.name ?? "Unknown Option!"
        }
        return "Unknown Option!"
    }
    
    func getPrice(distance: Double) -> Double {
        let price = distance / 200.0
        return ceil(price) // round up to the nearest dollar
    }
    

    func getDistance(from location: CLLocationCoordinate2D, to eateryLocationString: String) -> Double {
        print("Getting distance from \(location) to \(eateryLocationString)")
        let coordinates = eateryLocationString.split(separator: ",").map { Double($0.trimmingCharacters(in: .whitespaces)) }
        if let latitude = coordinates.first, let longitude = coordinates.last {
            let eateryLocation = CLLocation(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
            let userLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            return userLocation.distance(from: eateryLocation)
        }
        return 0.0
    }

    func calculateTotalPrice() -> Double {
        guard let userLocation = locationManager.lastKnownLocation else {
            return 0.0
        }
        
        return cartItems.reduce(0.0) { total, item in
            let distance = getDistance(from: userLocation, to: getEateryLocationById(item.eatery_id))
            let price = getPrice(distance: distance)
            return total + price
        }
    }
    
    var body: some View {
        ScrollView {
             VStack(alignment: .leading) {
                 HStack {
                     Text("Cart")
                         .font(.largeTitle)
                         .fontWeight(.bold)
                         .padding(.leading, 12)
                         .padding(.bottom, 5)
                         .padding(.top, 15)
                     Spacer()
                     Button {
                         showCart = false
                     } label: {
                         Text("Cancel")
                     }
                     .padding(.trailing, 12)
                     .padding(.top, 15)
                 }
                ForEach(cartItems, id: \.self) { item in
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 80)
                            .foregroundColor(.blue)
                            .shadow(radius: 4)
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.title2)
                                    .foregroundColor(.black)
                                if let userLocation = locationManager.lastKnownLocation {
                                    let distance = getDistance(from: userLocation, to: getEateryLocationById(item.eatery_id))
                                    let price = getPrice(distance: distance)
                                    Text("\(getEateryById(item.eatery_id)) · \(String(format: "%.2f", distance))m · $\(String(format: "%.2f", price))")
                                        .foregroundColor(.black)
                                } else {
                                    Text("\(getEateryById(item.eatery_id)) · Unknown Distance · Unknown Price")
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.leading, 12)
                            Spacer()
                            Button {
                                showAlert = true
                                itemToDelete = item
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .padding(.trailing, 20)
                                    .font(.title2)
                                    .foregroundColor(.black)
                            }
                            .alert("Confirm Deletion", isPresented: $showAlert, presenting: itemToDelete) { item in
                                Button("Delete", role: .destructive) {
                                    deleteItems(at: [cartItems.firstIndex(of: item) ?? 0])
                                }
                                Button("Cancel", role: .cancel) { }
                            } message: { item in
                                Text("Are you sure you want to delete \(item.name)?")
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                }
                
                Text("Total Price: $\(String(format: "%.2f", calculateTotalPrice()))")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.leading, 12)
                    .padding(.top, 10)
                 
                Spacer()
                
                // Apple Pay Button
                Button(action: {
                    // Simulate a fake charge
                    print("Processing Apple Pay charge...")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        print("Charge successful!")
                    }
                    
                    // SUBMIT ORDER TO API HERE
                    // CLEAR CART
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                            .font(.title)
                        Text("Pay with Apple Pay")
                            .fontWeight(.medium)
                            .padding(.leading, 5)
                            .padding(.top, 2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding(.horizontal, 12)
                .padding(.top, 20)
                
                // Cancel Button
                Button(action: {
                    // Clear the cart
                    cartItems.removeAll()
                    if let data = try? JSONEncoder().encode(cartItems) {
                        UserDefaults.standard.set(data, forKey: "cartItems")
                    }
                }) {
                    Text("Cancel Order")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 12)
                .padding(.top, 10)
                 
                 
            }
        }
        .onAppear(perform: loadCartItems)
    }
    
    private func getEateryLocationById(_ id: Int) -> String {
        return defaultEateries[String(id)]?.location ?? "0.0, 0.0"
    }

    private func loadCartItems() {
        if let data = UserDefaults.standard.data(forKey: "cartItems"),
           let savedItems = try? JSONDecoder().decode([FoodItem].self, from: data) {
            cartItems = savedItems
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        cartItems.remove(atOffsets: offsets)

        if let data = try? JSONEncoder().encode(cartItems) {
            UserDefaults.standard.set(data, forKey: "cartItems")
        }
    }
}

#Preview {
    @Previewable @StateObject var locationManager = LocationManager()
    @Previewable @State var showCart = true

    CartView(showCart: $showCart)
        .environmentObject(locationManager)
}
