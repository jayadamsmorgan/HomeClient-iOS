import Foundation

struct Error {
    
    init(_ message: String, _ errorType: ErrorType?) {
        self.message = message
        self.type = errorType ?? .DEFAULT_ERROR
    }
    
    let message: String
    let type: ErrorType
    
}

enum ErrorType {
    case DEFAULT_ERROR
    
    case UDP_ERROR
}
