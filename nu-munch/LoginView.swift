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
                    InputView(text: $username,
                              title: "Email Address",
                              placeholder: "name@example.com")
                        .autocapitalization(.none)
                    
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Sign in button using AuthManager for Auth0 login
                Button {
//                    AuthManager.shared.login { result in
//                        DispatchQueue.main.async {
//                            switch result {
//                            case .success(let credentials):
//                                print("Logged in successfully with access token: \(credentials.accessToken)")
//                                // Optionally, update app state or navigate to the main content here.
//                            case .failure(let error):
//                                print("Failed to log in: \(error.localizedDescription)")
//                            }
//                        }
//                    }
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
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}






// THIS BELOW WILL BE UNCOMMENTED AT THE END


////
////  ContentView.swift
////  iOS SwiftUI Login
////
////  Created by Auth0 on 7/18/22.
////  Companion project for the Auth0 video
////  “Integrating Auth0 within a SwiftUI app”
////
////  Licensed under the Apache 2.0 license
////  (https://www.apache.org/licenses/LICENSE-2.0)
////
//
//
//// modified by conrad booker 2025
//
//import SwiftUI
//import Auth0
//import JWTDecode
//
//
//struct LoginView: View {
//
//  @State private var isAuthenticated = false
//  @State var userProfile = Profile.empty
//
//    @AppStorage("email") var email: String = ""
//
//  var body: some View {
//
//    if isAuthenticated {
//        ContentView()
//            .onAppear {
//                email = userProfile.email
//            }
//    } else {
//
//      // “Logged out” screen
//      // ------------------
//      // When the user is logged out, they should see:
//      //
//      // - The title text “SwiftUI Login Demo”
//      // - The ”Log in” button
//
//      VStack {
//
//        Text("Hello")
//          .modifier(TitleStyle())
//
//        Button("Log in") {
//          login()
//        }
//        .buttonStyle(MyButtonStyle())
//
//      } // VStack
//
//    } // if isAuthenticated
//
//  } // body
//
//
//  // MARK: Custom views
//  // ------------------
//
//  struct UserImage: View {
//    // Given the URL of the user’s picture, this view asynchronously
//    // loads that picture and displays it. It displays a “person”
//    // placeholder image while downloading the picture or if
//    // the picture has failed to download.
//
//    var urlString: String
//
//    var body: some View {
//      AsyncImage(url: URL(string: urlString)) { image in
//        image
//          .frame(maxWidth: 128)
//      } placeholder: {
//        Image(systemName: "person.circle.fill")
//          .resizable()
//          .scaledToFit()
//          .frame(maxWidth: 128)
//          .foregroundColor(.blue)
//          .opacity(0.5)
//      }
//      .padding(40)
//    }
//  }
//
//
//  // MARK: View modifiers
//  // --------------------
//
//  struct TitleStyle: ViewModifier {
//    let titleFontBold = Font.title.weight(.bold)
//    let navyBlue = Color(red: 0, green: 0, blue: 0.5)
//
//    func body(content: Content) -> some View {
//      content
//        .font(titleFontBold)
//        .foregroundColor(navyBlue)
//        .padding()
//    }
//  }
//
//  struct MyButtonStyle: ButtonStyle {
//    let navyBlue = Color(red: 0, green: 0, blue: 0.5)
//
//    func makeBody(configuration: Configuration) -> some View {
//      configuration.label
//        .padding()
//        .background(navyBlue)
//        .foregroundColor(.white)
//        .clipShape(Capsule())
//    }
//  }
//
//}
//
//
//extension LoginView {
//
//  func login() {
//    Auth0
//      .webAuth()
//      .start { result in
//        switch result {
//          case .failure(let error):
//            print("Failed with: \(error)")
//
//          case .success(let credentials):
//            self.isAuthenticated = true
//            self.userProfile = Profile.from(credentials.idToken)
//            print("Credentials: \(credentials)")
//            print("ID token: \(credentials.idToken)")
//        }
//      }
//  }
//
//  func logout() {
//    Auth0
//      .webAuth()
//      .clearSession { result in
//        switch result {
//          case .success:
//            self.isAuthenticated = false
//            self.userProfile = Profile.empty
//
//          case .failure(let error):
//            print("Failed with: \(error)")
//        }
//      }
//  }
//
//}
//
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
//
//struct Profile {
//
//  let id: String
//  let name: String
//  let email: String
//  let emailVerified: String
//  let picture: String
//  let updatedAt: String
//
//}
//
//
//extension Profile {
//
//  static var empty: Self {
//    return Profile(
//      id: "",
//      name: "",
//      email: "",
//      emailVerified: "",
//      picture: "",
//      updatedAt: ""
//    )
//  }
//
//  static func from(_ idToken: String) -> Self {
//    guard
//      let jwt = try? decode(jwt: idToken),
//      let id = jwt.subject,
//      let name = jwt.claim(name: "name").string,
//      let email = jwt.claim(name: "email").string,
//      let emailVerified = jwt.claim(name: "email_verified").boolean,
//      let picture = jwt.claim(name: "picture").string,
//      let updatedAt = jwt.claim(name: "updated_at").string
//    else {
//      return .empty
//    }
//
//    return Profile(
//      id: id,
//      name: name,
//      email: email,
//      emailVerified: String(describing: emailVerified),
//      picture: picture,
//      updatedAt: updatedAt
//    )
//  }
//
//}
