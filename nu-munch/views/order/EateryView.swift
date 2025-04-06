//
//  EateryView.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import SwiftUI

struct EateryView: View {
    
    var eatery: Eatery?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text(eatery?.name ?? "Error")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 12)
                        .padding(.bottom, 5)
                    ForEach(defaultFoodItems.keys.sorted(), id: \.self) { foodItem_key in
                        ItemRow(foodItem: defaultFoodItems[foodItem_key])
                    }
                }
            }
        }
    }
}

#Preview {
    EateryView(eatery: defaultEateries["0"])
}
