import Foundation
import SwiftUI

class LightDevice: Device, ObservableObject {
    
    private var identifier: String {
            return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
            return hasher.combine(identifier)
    }
    
    static func == (lhs: LightDevice, rhs: LightDevice) -> Bool {
        lhs.id == rhs.id
    }
    
    
    init(id: Int, name: String, location: Location, data: String, ipAddress: String, on: Bool) {
        self.id = id
        self.name = name
        self.ipAddress = ipAddress
        self.on = on
        self.data = data
        self.location = location
    }
    
    var id: Int
    
    var name: String
    
    internal var location: Location
    
    var data: String = ""
    
    var ipAddress: String
    
    var on: Bool
    
    func changeLocation(newLocation: Location) {
        self.location = newLocation
        _ = location.addDevice(self)
    }
    
    func getLocation() -> Location {
        location
    }

}
