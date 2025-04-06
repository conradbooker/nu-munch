//
//  EateryView.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import SwiftUI

struct EateryView: View {
    var eatery: Eatery?
    @State private var foodItems: [String: FoodItem] = [:]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text(eatery?.name ?? "Error")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 12)
                        .padding(.bottom, 5)
                    ForEach(foodItems.keys.sorted(), id: \.self) { foodItem_key in
                        ItemRow(foodItem: foodItems[foodItem_key])
                    }
                }
                .onAppear {
                    if let eateryId = eatery?.id {
                        ApiCall().getEateryItems(eateryId: eateryId) { result in
                            switch result {
                            case .success(let fetchedFoodItems):
                                var foodItemDict: [String: FoodItem] = [:]
                                fetchedFoodItems.forEach { foodItem in
                                    foodItemDict[foodItem.id] = foodItem
                                }
                                self.foodItems = foodItemDict
                            case .failure(let error):
                                print("Failed to fetch food items: \(error)")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    EateryView(eatery: defaultEateries["0"])
}
