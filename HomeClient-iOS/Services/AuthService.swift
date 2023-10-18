import Foundation
import Siesta
import Strongbox

class AuthService {
    
    public static let shared = AuthService()
    
    private let tokenService = TokenService.shared
    private let networkManager = NetworkManager.shared
    
    var homeName: String?
    var userID: String?
    
    fileprivate init() {
        
    }
    
    func loadAuthResponse() {
        let strongbox = Strongbox()
        self.tokenService.token = strongbox.unarchive(objectForKey: "HomeClientToken") as? String ?? ""
        self.homeName = strongbox.unarchive(objectForKey: "HomeClientHomeName") as? String ?? ""
        self.userID = strongbox.unarchive(objectForKey: "HomeClientUserID") as? String ?? ""
        networkManager.baseURL = strongbox.unarchive(objectForKey: "HomeClientBaseURL") as? String ?? ""
        networkManager.start(baseURL: networkManager.baseURL)
    }
    
    func saveAuthResponse(_ baseURL: String, _ authResponse: AuthResponse) {
        if let token = authResponse.token {
            let strongbox = Strongbox()
            strongbox.archive(baseURL, key: "HomeClientBaseURL")
            strongbox.archive(token, key: "HomeClientToken")
            strongbox.archive(authResponse.homeName ?? "UNKNOWN", key: "HomeClientHomeName")
            strongbox.archive(authResponse.userID ?? "UNKNOWN", key: "HomeClientUserID")
        } else {
            print("Cannot save auth response: 'token' is nil")
        }
    }
    
    func clearAuthResponse() {
        let strongbox = Strongbox()
        strongbox.remove(key: "HomeClientBaseURL")
        strongbox.remove(key: "HomeClientToken")
        strongbox.remove(key: "HomeClientHomeName")
        strongbox.remove(key: "HomeClientUserID")
    }
    
    func registerHome(homeName: String,
                      username: String,
                      password: String,
                      save: Bool,
                      handleFinish: @escaping ( _ error: Error?, _ response: AuthResponse? ) -> Void ) {
        let authorizationRequest = AuthorizationRequest(username: username, password: password)
        let homeRegistrationRequest = HomeRegistrationRequest(registrationRequest: authorizationRequest, homeName: homeName)
        let request = networkManager.post(resource: "/auth/register/home", object: homeRegistrationRequest)
        request?
            .onSuccess { callback in
                do {
                    let authResponse = try JSONDecoder().decode(AuthResponse.self, from: callback.content as! Data)
                    if save && authResponse.error == nil {
                        self.saveAuthResponse(self.networkManager.baseURL, authResponse)
                    }
                    if authResponse.error == nil
                            && authResponse.homeName != nil
                            && authResponse.userID != nil
                            && authResponse.token != nil {
                        self.homeName = authResponse.homeName
                        self.userID = authResponse.userID
                        self.tokenService.token = authResponse.token!
                    }
                    handleFinish(nil, authResponse)
                } catch {
                    handleFinish(error, nil)
                }
            }
            .onFailure { callback in
                handleFinish(callback, nil)
            }
    }
    
    func login(username: String,
               password: String,
               save: Bool,
               handleFinish: @escaping (_ error: Error?, _ response: AuthResponse? ) -> Void ) {
        let authorizationRequest = AuthorizationRequest(username: username, password: password)
        let request = networkManager.post(resource: "/auth/login", object: authorizationRequest)
        request?
            .onSuccess { callback in
                do {
                    let authResponse = try JSONDecoder().decode(AuthResponse.self, from: callback.content as! Data)
                    if save && authResponse.error == nil {
                        print("AUTH OK")
                        self.saveAuthResponse(self.networkManager.baseURL, authResponse)
                    }
                    if authResponse.error == nil
                            && authResponse.homeName != nil
                            && authResponse.userID != nil
                            && authResponse.token != nil {
                        self.homeName = authResponse.homeName
                        self.userID = authResponse.userID
                        self.tokenService.token = authResponse.token!
                    }
                    handleFinish(nil, authResponse)
                } catch {
                    handleFinish(error, nil)
                }
            }
            .onFailure { callback in
                handleFinish(callback, nil)
            }
    }
    
    func logout(handleFinish: @escaping ( _ isOK: Bool ) -> Void ) {
        // TODO: logout from server
    }
    
    func renewToken(handleFinish: @escaping ( _ isOK: Bool ) -> Void ) {
        // TODO: token renewal realization
    }
    
}

private struct AuthorizationRequest : Encodable {
    let username: String
    let password: String
}

private struct HomeRegistrationRequest: Encodable {
    let registrationRequest: AuthorizationRequest
    let homeName: String
}

struct AuthResponse : Decodable {
    let userID: String?
    let token: String?
    let homeName: String?
    let error: String?
}
