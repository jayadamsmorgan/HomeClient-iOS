import Foundation

struct DeviceWrapper: Decodable {
    var device: BasicDevice
        
    fileprivate enum CodingKeys: String, CodingKey {
        case deviceType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let deviceType = try container.decode(String.self, forKey: .deviceType)
        
        guard let device = try DeviceFactory.shared.create(deviceType: deviceType, from: decoder) else {
            throw DecodingError.dataCorruptedError(forKey: .deviceType, in: container, debugDescription: "Invalid device type")
        }
        
        self.device = device
    }
}
