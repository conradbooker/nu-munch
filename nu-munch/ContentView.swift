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

    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    // Custom Header
                    HeaderView(view: $view)
                        .onAppear {
                            locationManager.checkLocationAuthorization()
                        }

                    if view == "order" {
                        OrderView()
                            .ignoresSafeArea()
                    } else {
                        
                    }
                    // Rest of the content
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
            .navigationBarHidden(true) // Hide default nav bar
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCart) {
            CartView(showCart: $showCart)
                .environmentObject(locationManager)
        }
    }
}

#Preview {
    ContentView()
}
