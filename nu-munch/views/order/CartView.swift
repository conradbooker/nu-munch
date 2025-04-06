import SwiftUI
import CoreLocation

struct CartView: View {
    @Binding var showCart: Bool
    @State private var cartItems: [FoodItem] = []
    @State private var showAlert: Bool = false
    @State private var itemToDelete: FoodItem?
    
    @State var eateries: [String: Eatery]?
    
    @EnvironmentObject private var locationManager: LocationManager
    
    @State private var showUserSuccess = false
    
    func getEateryById(_ id: String) -> String {
        if ((eateries?.keys.contains(String(id))) != nil) {
            return eateries?[String(id)]?.name ?? "Unknown Option!"
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
                 if showUserSuccess {
                     PaymentSuccessView()
                 }
                ForEach(cartItems, id: \.self) { item in
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 80)
                            .foregroundColor((.gray.opacity(0.2)))
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
                    if !cartItems.isEmpty {
                        
                        // SUBMIT ORDER TO API HERE
                        let expirationTime = Int(Date().addingTimeInterval(45 * 60).timeIntervalSince1970)
                        let newOrder = Order(
                            id: UUID().uuidString,
                            status: "In Progress",
                            foodItem_id: cartItems.first?.id ?? "",
                            locationStart: eateries?[cartItems.first?.eatery_id ?? "0"]?.location ?? "",
                            locationEnd: "\(locationManager.lastKnownLocation?.latitude ?? 0), \(locationManager.lastKnownLocation?.longitude ?? 0)",
                            locationStart_description: eateries?[cartItems.first?.eatery_id ?? "0"]?.name ?? "",
                            locationEnd_description: "Elder",
                            price: calculateTotalPrice(),
                            deliverer: "",
                            orderer: "0",
                            expiration: expirationTime
                        )
                        ApiCall().createOrder(order: newOrder) { result in
                            switch result {
                            case .success(let order):
                                print("Order created: \(order)")
                                // Clear the cart
                                cartItems.removeAll()
                                if let data = try? JSONEncoder().encode(cartItems) {
                                    UserDefaults.standard.set(data, forKey: "cartItems")
                                }
                            case .failure(let error):
                                print("Failed to create order: \(error)")
                            }
                        }
                        // clear cart
                        cartItems.removeAll()
                        if let data = try? JSONEncoder().encode(cartItems) {
                            UserDefaults.standard.set(data, forKey: "cartItems")
                        }
                        showUserSuccess = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showCart = false
                        }
                    }
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
    
    private func getEateryLocationById(_ id: String) -> String {
        return eateries?[String(id)]?.location ?? "0.0, 0.0"
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

extension ApiCall {
    func createOrder(order: Order, completion: @escaping (Result<Order, Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/orders/\(order.id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(order)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            
            do {
                let feedback = try JSONDecoder().decode(Response<Order>.self, from: data)
                if feedback.status == "success" {
                    completion(.success(feedback.feedback))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: feedback.feedback])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

#Preview {
    @Previewable @StateObject var locationManager = LocationManager()
    @Previewable @State var showCart = true

    CartView(showCart: $showCart, eateries: defaultEateries)
        .environmentObject(locationManager)
}
