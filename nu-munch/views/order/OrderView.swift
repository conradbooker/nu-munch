//
//  Order.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import SwiftUI

struct OrderView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(areas, id: \.self) { area in
                        Text(area)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading, 12)
                            .padding(.bottom, 5)
                        ForEach(defaultEateries.keys.sorted(), id: \.self) { eatery_key in
//                            Text(defaultEateries[eatery_key]?.area ?? "")
                            if defaultEateries[eatery_key]?.area ?? "" == area {
                                NavigationLink {
                                    EateryView(eatery: defaultEateries[eatery_key])
                                } label: {
                                    EateryRow(eatery: defaultEateries[eatery_key])
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview {
    OrderView()
}
