import SwiftUI

struct ProfileView: View {
    // Values passed in from RegistrationView
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
    
    @Binding var showProfile: Bool
    
    @State private var userData: User?
    
    var body: some View {
        VStack {
            // MARK: - List with Rounded Sections
            List {
                // 1) Top Section: Circle Avatar + Name + Email
                Section {
                    HStack {
                        if let user = userData {
                            Text(getInitials(from: user.name))
                                .font(.title)
                                .fontWeight(.semibold)
                                .frame(width: 72, height: 72)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.name)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                
                                Text(user.email)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                
                                Text("Current Balance: $\(user.currentBalance)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                
                                Text("Total Balance: $\(user.totalBalance)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                            }
                        } else {
                            Text("Loading...")
                                .onAppear {
                                    ApiCall().getUser(userId: "0") { result in
                                        switch result {
                                        case .success(let user):
                                            self.userData = user
                                        case .failure(let error):
                                            print(error)
                                        }
                                    }
                                }
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                
            }
            .listStyle(.insetGrouped)
            
            // MARK: - Save Changes Button (outside the List)
            Spacer()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        @Previewable @State var showProfile: Bool = false
        NavigationStack {
            ProfileView(showProfile: $showProfile)
        }
    }
}
