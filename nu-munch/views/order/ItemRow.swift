//
//  ItemRow.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import SwiftUI

struct ItemRow: View {
    
    @State private var showItem: Bool = false
    @State private var userInput: String = ""
    let prompt: String = "Type here..."

    var foodItem: FoodItem?
    
    @State private var selected: String = ""
    
    private let selectionOptions = [ //This is the List of values we'll use
        "my first option",
        "my second option",
        "my third option"
    ]
    
    var body: some View {
        Button {
            selected = foodItem?.options.first ?? ""
            print(selected)
            showItem = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 80)
                    .foregroundColor(.blue)
                    .shadow(radius: 4)
                HStack {
                    VStack(alignment: .leading) {
                        Text(foodItem?.name ?? "Loading...")
                            .font(.title2)
                            .foregroundColor(.black)
                        Text(foodItem?.description ?? "")
                            .foregroundColor(.black)
                        
                    }
                    .padding(.leading, 12)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding(.trailing, 12)
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 10)
        .sheet(isPresented: $showItem) {
            print("Sheet dismissed!")
        } content: {
            VStack(alignment: .leading) {
                HStack {
                    Text(foodItem?.name ?? "Loading...")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.vertical, 5)
                        .padding(.top, 10)
                    Spacer()
                    Button {
                        showItem = false
                    } label: {
                        Text("Cancel")
                    }
                }
                Text(foodItem?.description ?? "")
                    .font(.title3)
                    .padding(.bottom, 5)
                Spacer().frame(height: 30)
                Text("Options:")
                Picker("Picker Name", selection: $selected) {
                    ForEach(foodItem?.options ?? [], id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                Spacer().frame(height: 35)
                Text("Any additional requests/modifications?")
                TextEditor(text: $userInput)
                    .frame(maxHeight: 120)
                    .padding(8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                        if userInput.isEmpty {
                            VStack {
                                HStack {
                                    Text(prompt)
                                        .foregroundStyle(Color.secondary)
                                        .padding(12)
                                        .padding(.top, 4)
                                    Spacer()
                                }
                                Spacer()
                            }
                            .allowsHitTesting(false)
                        }
                    }
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        addToCart(foodItem: foodItem)
                        showItem = false
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.blue)
                            Text("Add to basket!")
                                .foregroundStyle(.white)
                                .font(.title3)
                        }
                        .frame(width: 250, height: 50)
                    }
                    Spacer()
                }
                .padding(.bottom, 50)
                
            }
            .padding(.horizontal, 12)
        }

    }

    private func addToCart(foodItem: FoodItem?) {
        guard let foodItem = foodItem else { return }

        var cartItems = getCartItems()
        cartItems.append(foodItem)

        if let data = try? JSONEncoder().encode(cartItems) {
            UserDefaults.standard.set(data, forKey: "cartItems")
        }
    }

    private func getCartItems() -> [FoodItem] {
        if let data = UserDefaults.standard.data(forKey: "cartItems"),
           let cartItems = try? JSONDecoder().decode([FoodItem].self, from: data) {
            return cartItems
        }
        return []
    }
}

#Preview {
    ItemRow(foodItem: defaultFoodItems["0"])
}
