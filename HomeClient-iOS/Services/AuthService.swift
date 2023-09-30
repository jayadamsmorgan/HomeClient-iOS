import Foundation
import Siesta
import Strongbox

class AuthService {
    
    private let tokenService : TokenService
    private let networkManager : NetworkManager
    
    init(_ tokenService: TokenService, _ networkManager: NetworkManager) {
        self.tokenService = tokenService
        self.networkManager = networkManager
    }
    
    func login(baseURL: String, login: String, password: String, handleFinish: @escaping ( _ isOK: Bool, _ param: String? ) -> Void ) {
        let authorizationRequest = AuthorizationRequest(login: login, password: password)
        let request = networkManager.post(resource: "/auth/authenticate", object: authorizationRequest)
        request?
            .onSuccess { callback in
                do {
                    let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: callback.content as! Data)
                    let strongbox = Strongbox()
                    strongbox.archive(baseURL, key: "HomeClientBaseURL")
                    _ = self.tokenService.saveToken(tokenResponse.token)
                    self.networkManager.setAuthToken()
                    handleFinish(true, tokenResponse.token)
                } catch {
                    print("Failed to decode JSON")
                    print(error.localizedDescription)
                    handleFinish(false, "DecodingFailure")
                }
            }
            .onFailure { callback in
                let errorCode = String(callback.httpStatusCode ?? -1)
                print("Error logging in, status code: " + errorCode)
                handleFinish(false, errorCode)
            }
    }
    
    func logout() {
        // TODO: logout from server
    }
    
    func renewToken() {
        // TODO: token renewal realization
    }
    
}

private struct AuthorizationRequest : Encodable {
    var login: String
    var password: String
}

private struct TokenResponse : Decodable {
    var userID: String
    var token: String
}
