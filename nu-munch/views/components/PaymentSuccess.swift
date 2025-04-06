//
//  PaymentSuccess.swift
//  nu-munch
//
//  Created by Conrad on 4/6/25.
//

// element generated with copilot

import SwiftUI

struct PaymentSuccessView: View {
    var body: some View {
        HStack {
            // Green checkmark circle
            ZStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 30, height: 30)
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
            }
            .padding(.leading, 10)
            
            // Payment successful text
            Text("Payment Successful")
                .font(.headline)
                .padding(.leading, 10)
            
            Spacer()
        }
        .frame(height: 80)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(12)
    }
}

struct PaymentSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentSuccessView()
    }
}
