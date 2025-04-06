//
//  AuthManager.swift
//  nu-munch
//
//  Required Dependencies:
//  - Auth0 Swift SDK: https://github.com/auth0/Auth0.swift
//  - KeychainAccess: https://github.com/kishikawakatsumi/KeychainAccess
//
//  (Install these via Swift Package Manager or CocoaPods.)
//

//import Foundation
//import Auth0
//
//class AuthManager {
//    static let shared = AuthManager()
//    
//    private let keychain: KeychainService
//    
//    private init() {
//        keychain = KeychainService.shared
//    }
//    
//    /// Starts the Auth0 login flow using the web authentication UI.
//    func login(completion: @escaping (Result<Credentials, Error>) -> Void) {
//        Auth0
//            .webAuth()
//            .scope("openid profile email") // Request the email scope
//            .start { result in
//                switch result {
//                case .success(let credentials):
//                    // Directly assign since accessToken and idToken are non-optional
//                    self.keychain.save(key: "access_token", value: credentials.accessToken)
//                    self.keychain.save(key: "id_token", value: credentials.idToken)
//                    
//                    // refreshToken remains optional; bind it if present
//                    if let refreshToken = credentials.refreshToken {
//                        self.keychain.save(key: "refresh_token", value: refreshToken)
//                    }
//                    completion(.success(credentials))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//    
//    /// Retrieve the access token from Keychain.
//    func getAccessToken() -> String? {
//        return keychain.load(key: "access_token")
//    }
//    
//    /// Retrieve the user's email from the ID token.
//    func getUserEmail() -> String? {
//        guard let idToken = keychain.load(key: "id_token") else { return nil }
//        
//        // Decode the ID token to extract the email
//        let jwtParts = idToken.split(separator: ".")
//        guard jwtParts.count == 3 else { return nil }
//        
//        let payload = String(jwtParts[1])
//        guard let payloadData = Data(base64Encoded: payload) else { return nil }
//        
//        do {
//            if let json = try JSONSerialization.jsonObject(with: payloadData, options: []) as? [String: Any],
//               let email = json["email"] as? String {
//                return email
//            }
//        } catch {
//            print("Failed to decode ID token: \(error.localizedDescription)")
//        }
//        
//        return nil
//    }
//    
//    /// Clears stored tokens from Keychain (e.g. for logout).
//    func logout() {
//        keychain.delete(key: "access_token")
//        keychain.delete(key: "id_token")
//        keychain.delete(key: "refresh_token")
//    }
//}
