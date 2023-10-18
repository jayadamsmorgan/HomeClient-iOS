import Siesta
import Foundation
import Security

class NetworkManager {
    
    private var service: Service?
    private let tokenService = TokenService.shared
    
    public static let shared = NetworkManager()
    
    fileprivate init() {
        
    }
    
    var baseURL: String = ""
    
    func start(baseURL: String) {
        service = Service(baseURL: baseURL, standardTransformers: [])
        self.baseURL = baseURL
        setAuthToken()
    }
    
    func setAuthToken() {
        service?.configure("**") {
            $0.headers["Authorization"] = "Bearer " + self.tokenService.getToken()
            print("Token: " + self.tokenService.getToken())
        }
    }
    
    // MARK: - GET
    
    func get(resource: String) -> Request? {
        print(baseURL + resource)
        return service?.resource(resource).request(.get)
    }
    
    // MARK: - POST
    
    func post<T: Encodable>(resource: String, object: T) -> Request? {
        do {
            let json = try JSONEncoder().encode(object)
            return service?.resource(resource).request(.post, data: json, contentType: "application/json")
        } catch {
            print("Failed to encode object: \(error)")
            return nil
        }
    }
    
    // MARK: - PUT
    
    func put<T: Encodable>(resource: String, object: T) -> Request? {
        do {
            let json = try JSONEncoder().encode(object)
            return service?.resource(resource).request(.put, data: json, contentType: "application/json")
        } catch {
            print("Failed to encode object: \(error)")
            return nil
        }
    }
    
    // MARK: - DELETE
    
    func delete(resource: String) -> Request? {
        return service?.resource(resource).request(.delete)
    }
    
}

struct ImageUploadResult {
    let isOK: Bool
    let id: String?
    let error: Int?
}

struct ImageUploadResponse: Decodable {
    let message: String
}

public enum ImageType {
    case png
    case jpeg
}
