//
//  ContentView.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var view: String = "order"
    @State private var showCart: Bool = false
    @StateObject private var locationManager = LocationManager()

    @AppStorage("email") var email = ""
    @AppStorage("user_id") var user_id = "0"
        
    @State private var activeOrder: Order?

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    
                    // Custom Header
                    HeaderView(view: $view)
                        .onAppear {
                            locationManager.checkLocationAuthorization()
                            user_id = "0"
                            
                        }
                        .padding(.top, 60)
                    // active delivery / order here
                    
                    Text("Active Order/Delivery")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 12)
                        .padding(.bottom, 5)

                    ActiveItem()
                        .environmentObject(locationManager)
                    

                    if view == "order" {
                        OrderView()
                            .ignoresSafeArea()
                            .environmentObject(locationManager)
                    } else {
                        DeliverView()
                            .environmentObject(locationManager)
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            showCart = true
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundStyle(.purple)
                                    .frame(width: 80, height: 80)
                                    .shadow(radius: 4)
                                Image(systemName: "basket")
                                    .font(.title)
                                    .foregroundStyle(.white)
                            }
                            .padding(.trailing, 30)
                            .padding(.bottom, 30)
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .navigationBarHidden(true) // Hide default nav bar
        }
        .sheet(isPresented: $showCart) {
            CartView(showCart: $showCart)
                .environmentObject(locationManager)
        }
    }
}

#Preview {
    ContentView()
}

