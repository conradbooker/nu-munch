import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @Environment(\.dismiss) var dismiss
    
    // Tracks whether we’re pushing to ProfileView
    @State private var showProfileView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("munch_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 250)
                
                // MARK: - Registration Fields
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $fullname,
                              title: "Full Name",
                              placeholder: "Enter your name")
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                    
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Confirm your password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // MARK: - Sign Up Button
                Button {
                    // Ideally, validate input here (e.g., confirmPassword match)
                    // Then set showProfileView to true:
                    showProfileView = true
                } label: {
                    HStack {
                        Text("SIGN UP")
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
                
                // MARK: - Already Have Account?
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        Text("Sign in")
                            .fontWeight(.bold)
                    }
                    .font(.system(size:14))
                }
            }
            .navigationDestination(isPresented: $showProfileView) {
                // Pass user inputs to ProfileView:
                ProfileView(email: email,
                            username: fullname,
                            password: password)
            }
        }
    }
}

