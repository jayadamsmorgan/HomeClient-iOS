import Foundation

class Location: Hashable, ObservableObject {
    
    init(locationName: String) {
        self.locationName = locationName
    }
    
    @Published public var locationName: String
    
    @Published private var devices: [any Device] = []
    
    public func getLightDevices() -> [LightDevice] {
        var lightDevices: [LightDevice] = []
        for device in devices {
            if type(of: device) == LightDevice.Type.self {
                lightDevices.append(device as! LightDevice)
            }
        }
        return lightDevices
    }
    
    public func getSensors() -> [Sensor] {
        var sensors: [Sensor] = []
        for device in devices {
            if type(of: device) == Sensor.Type.self {
                sensors.append(device as! Sensor)
            }
        }
        return sensors
    }
    
    public func addDevice(_ newDevice: any Device) -> Bool {
        if newDevice.location == self {
            devices.append(newDevice)
            return true
        } else {
            return false
        }
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
