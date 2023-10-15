import Foundation

class BasicDevice: Device, ObservableObject {
    
    private var identifier: String {
            return id
    }
    
    public func hash(into hasher: inout Hasher) {
            return hasher.combine(identifier)
    }
    
    static func == (lhs: BasicDevice, rhs: BasicDevice) -> Bool {
        lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case on
        case location
        case ipAddress
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: DeviceWrapper.CodingKeys.self).nestedContainer(keyedBy: BasicDevice.CodingKeys.self, forKey: .device)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        on = try values.decode(Bool.self, forKey: .on)
        locationString = try values.decode(String.self, forKey: .location)
        ipAddress = try values.decode(String.self, forKey: .ipAddress)
        data = try values.decode(String.self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(on, forKey: .on)
        try container.encode(ipAddress, forKey: .ipAddress)
        try container.encode(data, forKey: .data)
        try container.encode(locationString, forKey: .location)
    }
    
    init(id: String, name: String, on: Bool) {
        self.id = id
        self.name = name
        self.on = on
        self.locationString = ""
        self.ipAddress = ""
        self.data = ""
    }
    
    var id: String
    
    @Published var name: String
    
    @Published internal var on: Bool
    
    private var ipAddress: String
    
    internal var data: String
    
    private var locationString: String
    
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
    
}
