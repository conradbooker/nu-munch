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
                        ForEach(defaultEateries, id: \.self) { eatery in
                            if eatery.area == area {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(height: 80)
                                        .foregroundColor(.blue)
                                        .shadow(radius: 4)
                                    HStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .frame(width: 56, height: 56)
                                            .foregroundColor(.green)
                                            .padding(.leading, 12)
                                        VStack(alignment: .leading) {
                                            Text(eatery.name)
                                                .font(.title3)
                                            Text("900m away · Closes at 6pm")
                                            
                                        }
                                        .padding(.leading, 12)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .padding(.trailing, 12)
                                    }
                                }
                                .padding(.horizontal, 12)
                                .padding(.bottom, 10)
                                
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
