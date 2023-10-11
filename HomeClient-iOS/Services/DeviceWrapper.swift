import Foundation

struct DeviceWrapper: Codable {
    var device: BasicDevice
    var deviceType: String
        
    enum CodingKeys: String, CodingKey {
        case deviceType
        case device
    }
    
    init(deviceType: String, device: BasicDevice) {
        self.deviceType = deviceType
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
}
