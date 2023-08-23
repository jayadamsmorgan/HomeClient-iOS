import Foundation

class RGBLight: LightDevice {
    
    var red: Int = 0
    var green: Int = 0
    var blue: Int = 0
    
    override init(id: Int, name: String, location: Location, data: String, ipAddress: String, on: Bool) {
        super.init(id: id, name: name, location: location, data: data, ipAddress: ipAddress, on: on)
        (red, green, blue, _) = getRGBWData(data: data)
    }
    
    private func getRGBWData(data: String) -> (red: Int, green: Int, blue: Int, white: Int) {
        let splitData = data.components(separatedBy: ";")
        var red: Int = 0
        var green: Int = 0
        var blue: Int = 0
        var white: Int = 0
        for key in splitData {
            if key.contains("red") {
                let strValue = key.components(separatedBy: "=").last ?? ""
                red = Int(strValue) ?? 0
            }
            if key.contains("green") {
                let strValue = key.components(separatedBy: "=").last ?? ""
                green = Int(strValue) ?? 0
            }
            if key.contains("blue") {
                let strValue = key.components(separatedBy: "=").last ?? ""
                blue = Int(strValue) ?? 0
            }
            if key.contains("white") {
                let strValue = key.components(separatedBy: "=").last ?? ""
                white = Int(strValue) ?? 0
            }
        }
        return (red, green, blue, white)
    }
    
}
