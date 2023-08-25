import Foundation
import SwiftUI

class Location: Hashable, ObservableObject, Identifiable {
    
    init(locationName: String) {
        self.locationName = locationName
    }
    
    @Published public var locationName: String
    
    @Published var rgbLightDevices: [RGBLight] = []
    @Published var lightDevices: [LightDevice] = []
    @Published var sensors: [Sensor] = []
    
    public func addDevice(_ newDevice: any Device) -> Bool {
        switch type(of: newDevice) {
            
        case is RGBLight.Type:
            rgbLightDevices.append(newDevice as! RGBLight)
            return true
            
        case is LightDevice.Type:
            lightDevices.append(newDevice as! LightDevice)
            return true
            
        case is Sensor.Type:
            sensors.append(newDevice as! Sensor)
            return true
            
        default:
            print("DeviceType is not yet supported")
            
        }
        
        return false
    }
    
    private var identifier: String {
            return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
            return hasher.combine(identifier)
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.locationName == rhs.locationName
    }
}
