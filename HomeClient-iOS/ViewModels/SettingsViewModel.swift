import Foundation
import SwiftUI
import Strongbox

@MainActor class SettingsViewModel: ObservableObject {
    
    public static let shared = SettingsViewModel()
    
    private let sb = Strongbox()
    
    private final let ipAddressStrongboxKey = "HomeClientServerIP"
    
    fileprivate init() {
        
    }
    
    func saveServerIPAdress(ip: String) {
        sb.archive(ip, key: ipAddressStrongboxKey)
        NetworkManager.shared.start(baseURL: ip)
    }
    
    func getSavedServerIPAddress() -> String? {
        return sb.unarchive(objectForKey: ipAddressStrongboxKey) as? String
    }
    
}
