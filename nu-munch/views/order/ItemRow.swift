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

    private let selectionOptions = [
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
                    .frame(maxHeight: 120)
                    .foregroundColor(.gray.opacity(0.2))
                    .shadow(radius: 4)
                HStack {
                    VStack(alignment: .leading) {
                        Text(foodItem?.name ?? "Loading...")
                            .font(.title2)
                            .foregroundColor(.black)
                        Text(foodItem?.description ?? "")
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
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
            NavigationStack {
                Form {
                    Section(header: Text(foodItem?.name ?? "Loading...").font(.headline)) {
                        Text(foodItem?.description ?? "")
                    }

                    Section(header: Text("Options")) {
                        Picker("Select an option", selection: $selected) {
                            ForEach(foodItem?.options ?? [], id: \.self) { option in
                                Text(option)
                            }
                        }
                    }
    
                    Section(header: Text("Additional requests/modifications")) {
                        TextEditor(text: $userInput)
                            .frame(minHeight: 120)
                            .overlay {
                                if userInput.isEmpty {
                                    VStack {
                                        HStack {
                                            Text(prompt)
                                                .foregroundStyle(Color.secondary)
                                                .padding(12)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    .allowsHitTesting(false)
                                }
                            }
                    }

                    Section {
                        Button(action: {
                            addToCart(foodItem: foodItem)
                            showItem = false
                        }) {
                            HStack {
                                Spacer()
                                Text("Add to basket!")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                Spacer()
                            }
                        }
                        .listRowBackground(Color(.systemPurple))
                    }
                }
                .navigationTitle("Food Item")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Cancel") {
                            showItem = false
                        }
                    }
                }
            }
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

