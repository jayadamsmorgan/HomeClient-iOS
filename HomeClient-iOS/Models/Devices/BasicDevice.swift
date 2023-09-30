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
    
    fileprivate enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
        case data
        case ipAddress
        case on
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        ipAddress = try values.decode(String.self, forKey: .ipAddress)
        on = try values.decode(Bool.self, forKey: .on)
        let locationName = try values.decode(String.self, forKey: .location)
        location = LocationManager.shared.getLocationByName(locationName)!
        data = try values.decode(String.self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(location.locationName, forKey: .location)
        try container.encode(data, forKey: .data)
        try container.encode(ipAddress, forKey: .ipAddress)
        try container.encode(on, forKey: .on)
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
    
    internal func constraint0to100(value: Int) -> Int {
        var returnValue = max(0, value)
        returnValue = min(value, 100)
        return returnValue
    }
    
    internal func constraint0to255(value: Int) -> Int {
        var returnValue = max(0, value)
        returnValue = min(value, 255)
        return returnValue
    }
    
    func changeLocation(newLocation: Location) {
        self.location = newLocation
    }
    
    func getLocation() -> Location {
        location
    }
    
}
