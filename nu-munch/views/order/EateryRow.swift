//
//  EateryRow.swift
//  nu-munch
//
//  Created by Conrad on 4/5/25.
//

import SwiftUI

struct EateryRow: View {
    
    var eatery: Eatery?

    var body: some View {
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
                    Text(eatery?.name ?? "")
                        .font(.title2)
                        .foregroundColor(.black)
                    Text("900m away · Closes at 6pm")
                        .foregroundColor(.black)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.trailing, 12)
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 10)

    }
}

#Preview {
    EateryRow(eatery: defaultEateries["0"])
}
