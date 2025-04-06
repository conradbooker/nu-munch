//
//  LoginView.swift
//  nu-munch
//
//  Created by Daniel Wu on 4/5/25.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var loggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("munch_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 250)
                
                // Form fields
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                        .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Sign in button using AuthManager for Auth0 login
                Button {
                    AuthManager.shared.login { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let credentials):
                                print("Logged in successfully with access token: \(credentials.accessToken)")
                                // Optionally, update app state or navigate to the main content here.
                            case .failure(let error):
                                print("Failed to log in: \(error.localizedDescription)")
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemPurple))
                .cornerRadius(8)
                .padding(.top, 24)
                
                Spacer()
                
                // Sign up button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

