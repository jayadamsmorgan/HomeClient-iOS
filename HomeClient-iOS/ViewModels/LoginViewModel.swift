import Foundation
import SwiftUI

@MainActor class LoginViewModel: ObservableObject {
    
    @Published public var needsLogin: Bool = true
    
    public static let shared = LoginViewModel()
    
    fileprivate init() {
        
    }
    
    private func onResponse(error: Error?, response: AuthResponse?) {
        if let error = error {
            print("Authentication error: \(error)")
        }
        if let response = response {
            if let error = response.error {
                print("Authentication error: \(error)")
                return
            }
            guard response.homeName != nil else {
                print("Authentication error: 'homeName' is nil")
                return
            }
            guard response.token != nil else {
                print("Authentication error: 'token' is nil")
                return
            }
            guard response.userID != nil else {
                print("Authentication error: 'userID' is nil")
                return
            }
            withAnimation {
                self.needsLogin = false
            }
        }
    }
    
    func registerNewHome(homeName: String,
                         serverIP: String,
                         serverPort: Int,
                         username: String,
                         password: String,
                         saveLogin: Bool) {
        let baseURL: String = serverIP + String(serverPort)
        NetworkManager.shared.start(baseURL: baseURL)
        AuthService.shared.registerHome(homeName: homeName,
                                        username: username,
                                        password: password,
                                        save: saveLogin,
                                        handleFinish: onResponse)
    }
    
    func login(serverIP: String,
               serverPort: Int,
               username: String,
               password: String,
               saveLogin: Bool) {
        let baseURL: String = serverIP + String(serverPort)
        NetworkManager.shared.start(baseURL: baseURL)
        AuthService.shared.login(username: username,
                                 password: password,
                                 save: saveLogin,
                                 handleFinish: onResponse)
    }
}

