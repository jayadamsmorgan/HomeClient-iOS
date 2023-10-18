import Foundation
import SwiftUI


class HomeLightViewModel: ObservableObject {
    
    @Published public var locations = [Location]()

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
                return
            }
            self.objectWillChange.send()
            self.locations = locations
//            if self.locations.isEmpty {
//                return
//            }
            
        })
    }
    
    func sendDeviceState(device: any Device) {
        DeviceService.shared.updateDevice(device: device) { error in
            if error == nil {
                print("OK")
            } else {
                print("error \(error!)")
            }
        }
    }
    
}
