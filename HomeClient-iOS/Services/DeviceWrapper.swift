import Foundation

struct DeviceWrapper: Codable {
    var device: any Device
    var deviceType: String
        
    enum CodingKeys: String, CodingKey {
        case deviceType
        case device
    }
    
    init(device: any Device) {
        self.deviceType = String(describing: type(of: device))
        self.device = device
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        deviceType = try container.decode(String.self, forKey: .deviceType)
        
        guard let device = try DeviceFactory.shared.create(deviceType: deviceType, from: decoder) else {
            throw DecodingError.dataCorruptedError(forKey: .deviceType, in: container, debugDescription: "Invalid device type")
        }
        
        self.device = device
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DeviceWrapper.CodingKeys.self)
        try container.encode(device, forKey: .device)
        try container.encode(deviceType, forKey: .deviceType)
    }
}
