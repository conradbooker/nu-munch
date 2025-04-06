import SwiftUI

struct ProfileView: View {
    // Values passed in from RegistrationView
    @State var email: String
    @State var username: String
    @State var password: String
    
    @State private var isEditingPassword: Bool = false
    
    // Helper to derive initials (e.g. "Monica Lewis" -> "ML")
    private func getInitials(from name: String) -> String {
        let components = name.components(separatedBy: " ")
        let initials = components.reduce("") { partialResult, component in
            guard let firstChar = component.first else { return partialResult }
            return partialResult + String(firstChar)
        }
        return initials.uppercased()
    }
    
    var body: some View {
        VStack {
            // MARK: - List with Rounded Sections
            List {
                // 1) Top Section: Circle Avatar + Name + Email
                Section {
                    HStack {
                        Text(getInitials(from: username))
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(username)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(email)
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                
                // 2) Profile Fields Section
                Section {
                    // Email
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                    .autocapitalization(.none)
                    .listRowSeparator(.hidden)
                    
                    // Username
                    InputView(text: $username,
                              title: "Username",
                              placeholder: "Enter your username")
                    .listRowSeparator(.hidden)
                    
                    // Password (tap to toggle secure)
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: !isEditingPassword)
                    .onTapGesture {
                        isEditingPassword.toggle()
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.insetGrouped)
            
            // MARK: - Save Changes Button (outside the List)
            Button {
                // Handle saving logic here
                print("User tapped save changes with:")
                print("Email: \(email)")
                print("Username: \(username)")
                print("Password: \(password)")
            } label: {
                HStack {
                    Text("SAVE CHANGES")
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
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView(email: "test@example.com",
                        username: "Monica Lewis",
                        password: "MyPassword123")
        }
    }
}

