import Foundation
import JWTDecode
import Strongbox

class TokenService {
    
    private let sb = Strongbox()
    
    private let tokenKeychainKey : String = "HomeClientToken"
    
    var token : String = ""
    
    public static let shared = TokenService()
    
    private init() {
        _ = retrieveToken()
    }
    
    public func getToken() -> String {
        token
    }
    
    func saveToken(_ token: String) -> Bool {
        print("Saving token")
        sb.remove(key: tokenKeychainKey)
        sb.archive("Bearer \(token)", key: tokenKeychainKey)
        self.token = "Bearer " + token
        return true
    }
    
    func retrieveToken() -> Bool {
        if let tokenRetrieval = sb.unarchive(objectForKey: tokenKeychainKey) as? String {
            self.token = tokenRetrieval
            return true
        } else {
            self.token = ""
            return false
        }
    }
    
    func checkTokenExpiration() -> TokenExpirationState {
        print("Checking token expiration date")
        if (token == "") {
            return .NO_TOKEN_AVAILABLE
        }
        let tokenRaw = token.components(separatedBy: " ").last ?? ""
        do {
            let jwt = try decode(jwt: tokenRaw)
            if let expirationDate = jwt.claim(name: "exp").date {
                print("Expiration date: \(expirationDate)")
                let dateNow = Date.now
                if dateNow >= expirationDate {
                    return .EXPIRED
                } else {
                    let calendar = Calendar.current
                    let date = calendar.date(byAdding: .day, value: 2, to: dateNow) ?? dateNow
                    if (date >= expirationDate) {
                        return .ABOUT_TO_EXPIRE
                    }
                    return .NON_EXPIRED
                }
            } else {
                print("Failed to get expiration claim")
                return .NO_TOKEN_AVAILABLE
            }
        } catch {
            print("Failed to decode JWT: \(error)")
            return .NO_TOKEN_AVAILABLE
        }
    }
    
}

enum TokenExpirationState {
    case NO_TOKEN_AVAILABLE
    case EXPIRED
    case ABOUT_TO_EXPIRE
    case NON_EXPIRED
}
