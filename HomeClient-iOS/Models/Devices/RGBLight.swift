import Foundation

class RGBLight: LightDevice {
    
    // RGB value range: 0-255 (Int)
    
    @Published private var red: Int
    @Published private var green: Int
    @Published private var blue: Int
    
    init(id: Int, name: String, on: Bool,
         brightness: Int, red: Int, green: Int, blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
        super.init(id: id, name: name, on: on, brightness: brightness)
    }
    
    enum CodingKeys: String, CodingKey {
        case red
        case green
        case blue
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DeviceWrapper.CodingKeys.self)
            .nestedContainer(keyedBy: RGBLight.CodingKeys.self, forKey: .device)
        red = try container.decode(Int.self, forKey: .red)
        green = try container.decode(Int.self, forKey: .green)
        blue = try container.decode(Int.self, forKey: .blue)
        try super.init(from: decoder)
    }
    
    var getRed: Int {
        red
    }
    
    var getGreen: Int {
        green
    }
    
    var getBlue: Int {
        blue
    }
    
    func setRed(_ red: Int) {
        self.red = constraint0to255(value: red)
    }
    
    func setGreen(_ green: Int) {
        self.green = constraint0to255(value: green)
    }
    
    func setBlue(_ blue: Int) {
        self.blue = constraint0to255(value: blue)
    }
    
}
