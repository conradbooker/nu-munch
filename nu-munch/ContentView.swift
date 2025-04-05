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
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // Custom Header
                HeaderView(view: $view)

                // Rest of the content
                Spacer()
            }
            .navigationBarHidden(true) // Hide default nav bar
        }
    }
}

#Preview {
    ContentView()
}
