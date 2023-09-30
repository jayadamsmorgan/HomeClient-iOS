import Foundation

class LightDevice: BasicDevice {
    
    @Published private var brightness: Int
    
    init(id: Int, name: String, location: Location, data: String, ipAddress: String, on: Bool, brightness: Int) {
        self.brightness = brightness
        super.init(id: id, name: name, location: location, data: data, ipAddress: ipAddress, on: on)
        self.brightness = constraint0to100(value: brightness)
    }
    
    fileprivate enum CodingKeys: String, CodingKey {
        case brightness
    }
    
    required init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        brightness = try container.decode(Int.self, forKey: .brightness)
        try super.init(from: decoder)
        brightness = constraint0to100(value: brightness)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(brightness, forKey: .brightness)
        try super.encode(to: encoder)
    }
    
    var getBrightness: Int {
        brightness
    }
    
    func setBrightness(_ value: Int) {
        brightness = constraint0to100(value: value)
    }

}
