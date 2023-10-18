import Foundation
import SwiftUI

class Location: Hashable, ObservableObject, Identifiable, Codable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Location.CodingKeys.self)
        try container.encode(locationName, forKey: .locationName)
        try container.encode(devices as? [BasicDevice], forKey: .devices)
    }
    
    enum CodingKeys: String, CodingKey {
        case locationName
        case devices
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Location.CodingKeys.self)
        self.locationName = try container.decode(String.self, forKey: .locationName)
        let deviceWrappers = try container.decode([DeviceWrapper].self, forKey: .devices)
        self.devices = deviceWrappers.map { $0.device }
    }
    
    init(locationName: String) {
        self.locationName = locationName
    }
    
    @Published public var locationName: String
    
    @Published public var devices: [any Device] = []
    
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
