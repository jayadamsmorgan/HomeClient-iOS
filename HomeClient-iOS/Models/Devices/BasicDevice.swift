import Foundation

class BasicDevice: Device, ObservableObject {
    
    private var identifier: String {
            return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
            return hasher.combine(identifier)
    }
    
    static func == (lhs: BasicDevice, rhs: BasicDevice) -> Bool {
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
    
    @Published var name: String
    
    internal var location: Location
    
    @Published var data: String = ""
    
    var ipAddress: String
    
    @Published internal var on: Bool
    
    var isOn: Bool {
        on
    }
    
    func toggle() {
        on.toggle()
    }
    
    func changeLocation(newLocation: Location) {
        self.location = newLocation
        _ = location.addDevice(self)
    }
    
    func getLocation() -> Location {
        location
    }
    
}
