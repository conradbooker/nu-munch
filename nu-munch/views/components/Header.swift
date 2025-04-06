//
//  Header.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import SwiftUI

// API CALL ON APPEAR GET LENGTH OF ORDERS

struct HeaderView: View {
    
    @Binding var view: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 8) {
                    Button {
                        view = "order"
                        print(view)
                    } label: {
                        if view == "order" {
                            Text("Order")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                        } else {
                            Text("Order")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(.gray)
                        }
                    }

                    ZStack(alignment: .topTrailing) {
                        Button {
                            view = "deliver"
                            print(view)
                        } label: {
                            if view == "deliver" {
                                Text("Deliver")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                            } else {
                                Text("Deliver")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.gray)
                            }
                        }

                        // Notification Badge
                        Circle()
                            .fill(Color.red)
                            .frame(width: 16, height: 16)
                            .overlay(
                                Text("3")
                                    .foregroundColor(.white)
                                    .font(.caption2)
                            )
                            .offset(x: 16, y: -5)
                    }
                    .padding(.leading, 5)
                }

                Spacer()

                // Right Side (Profile icon)
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 36, height: 36)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                    )
            }

        }
        .padding()

    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        @State var view = "order"
        
        HeaderView(view: $view)
            .previewLayout(.sizeThatFits)
    }
}
