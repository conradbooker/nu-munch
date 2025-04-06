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
    @AppStorage("user_id") var user_id = ""
    
    @State private var showProfile = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    // active delivery / order here
                    
                    // Custom Header
                    HeaderView(view: $view)
                        .onAppear {
                            locationManager.checkLocationAuthorization()
                        }
                        .padding(.top, 60)

                    if view == "order" {
                        OrderView()
                            .ignoresSafeArea()
                            .environmentObject(locationManager)
                    } else {
                        // You can add additional views here.
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
        .sheet(isPresented: $showProfile) {
            ProfileView(showProfile: $showProfile)
        }
    }
}

#Preview {
    ContentView()
}

