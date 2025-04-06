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
            VStack{
                Spacer()
                    .onAppear {
                        if let savedUsername = KeychainService.shared.load(key: "username"),
                           let savedPassword = KeychainService.shared.load(key: "password") {
                            username = savedUsername
                            password = savedPassword
                            loggedIn = true
                        }
                    }
                if !loggedIn {
                    //form fields
                    VStack(spacing: 24) {
                        InputView(text: $username,
                                  title: "Email Address",
                                  placeholder: "name@example.com")
                        .autocapitalization(.none)
                        
                        InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    //sign in button
                    
                    Button {
                        KeychainService.shared.save(key: "username", value: username)
                        KeychainService.shared.save(key: "password", value: password)
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
                    
                    //sign up button
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 3) {
                            Text("Don't have an account?")
                            Text("Sign up")
                                .fontWeight(.bold)
                        }
                        .font(.system(size:14))
                    }

                } else {
                    ContentView()
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
