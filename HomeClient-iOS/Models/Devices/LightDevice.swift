import Foundation

struct LightDevice: Device {
    
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
    
    mutating func changeLocation(newLocation: Location) {
        self.location = newLocation
        _ = location.addDevice(self)
    }
    
    func getLocation() -> Location {
        location
    }

}

extension LightDevice {
    
    init(id: Int, name: String, locationString: String, data: String, ipAddress: String, on: Bool) {
        self.id = id
        self.name = name
        self.ipAddress = ipAddress
        self.on = on
        self.data = data
        let locationFactory = LocationFactory.getInstance()
        let location = locationFactory.getLocationByName(locationString)
        self.location = location
        _ = location.addDevice(self)
    }
    
    init(id: Int, name: String, locationString: String, ipAddress: String, on: Bool) {
        self.id = id
        self.name = name
        self.ipAddress = ipAddress
        self.on = on
        let locationFactory = LocationFactory.getInstance()
        let location = locationFactory.getLocationByName(locationString)
        self.location = location
        _ = location.addDevice(self)
        
    }
    
    init(id: Int, name: String, location: Location, ipAddress: String, on: Bool) {
        self.id = id
        self.name = name
        self.ipAddress = ipAddress
        self.on = on
        self.location = location
    }
    
}
