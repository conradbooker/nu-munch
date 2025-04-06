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

import Foundation
import Auth0
import KeychainAccess

class AuthManager {
    static let shared = AuthManager()
    
    private let keychain: Keychain
    
    private init() {
        // The service identifier is typically your app’s bundle ID.
        keychain = Keychain(service: "com.nu-munch.token")
    }
    
    /// Starts the Auth0 login flow using the web authentication UI.
    func login(completion: @escaping (Result<Credentials, Error>) -> Void) {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                case .success(let credentials):
                    // Directly assign since accessToken and idToken are non-optional
                    self.keychain["access_token"] = credentials.accessToken
                    self.keychain["id_token"] = credentials.idToken
                    
                    // refreshToken remains optional; bind it if present
                    if let refreshToken = credentials.refreshToken {
                        self.keychain["refresh_token"] = refreshToken
                    }
                    completion(.success(credentials))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    /// Retrieve the access token from Keychain.
    func getAccessToken() -> String? {
        return keychain["access_token"]
    }
    
    /// Clears stored tokens from Keychain (e.g. for logout).
    func logout() {
        keychain["access_token"] = nil
        keychain["id_token"] = nil
        keychain["refresh_token"] = nil
    }
}

