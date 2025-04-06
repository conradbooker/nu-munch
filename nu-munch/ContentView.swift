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
    @State private var showCart: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    // Custom Header
                    HeaderView(view: $view)
                    if view == "order" {
                        OrderView()
                            .ignoresSafeArea()
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
                            }
                            .padding(.trailing, 30)
                        }
                    }
                }
            }
            .navigationBarHidden(true) // Hide default nav bar
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCart) {
            CartView()
        }
    }
}

#Preview {
    ContentView()
}

