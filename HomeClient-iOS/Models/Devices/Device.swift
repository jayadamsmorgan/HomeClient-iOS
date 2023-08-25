import Foundation

protocol Device: Hashable, Identifiable {
    var id: Int { get set }
    var name: String { get set }
    var location: Location { get }
    var data: String { get set }
    var ipAddress: String { get set }
    var on: Bool { get set }
    
    mutating func changeLocation(newLocation: Location)
}

struct DeviceDTO: Codable {
    
    let id: Int?
    let name: String?
    let location: String?
    let data: String?
    let ipAddress: String?
    let on: Bool?
    let type: String?
    
}

enum DeviceType: String {
    
    // TODO: implement other DeviceTypes
    
    case basicDevice = "BasicDevice"
    
    case lightDevice = "LightDevice"
    
    case sensor = "Sensor"
    
    case rgbLight = "RGBLight"
    
    case rgbStrip = "RGBStrip"
    
    case rgbwStrip = "RGBWStrip"
    
}
