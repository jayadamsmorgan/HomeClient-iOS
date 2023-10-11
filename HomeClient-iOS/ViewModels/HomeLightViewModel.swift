import Foundation
import SwiftUI


class HomeLightViewModel: ObservableObject {
    
    @Published public var locations: [Location] = []

    public static let shared = HomeLightViewModel()
    
    fileprivate init() {
        
    }
    
    init(locations: [Location]) {
        self.locations = locations
    }
    
    public func fetchLocations() {
        DeviceService.shared.getLocations(handleFinish: { locations, error in
            if let error = error {
                print(error)
            } else {
                print("OK")
                self.locations = locations
            }
        })
    }
    
    func sendDeviceState() {
        
    }
    
}
