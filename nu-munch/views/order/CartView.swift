//
//  CartView.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Cart")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.vertical, 5)
                .padding(.top, 10)
            Spacer()
        }
    }
}

#Preview {
    CartView()
}
