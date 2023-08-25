import Foundation

class LightDevice: BasicDevice {
    
    @Published private var brightness: Int = 100
    
    override init(id: Int, name: String, location: Location, data: String, ipAddress: String, on: Bool) {
        super.init(id: id, name: name, location: location, data: data, ipAddress: ipAddress, on: on)
        brightness = LightDevice.getBrightnessData(data: data)
    }
    
    var getBrightness: Int {
        brightness
    }
    
    func setBrightness(_ value: Int) {
        brightness = LightDevice.brightnessValueConstraint(value)
    }
    
    private static func brightnessValueConstraint(_ value: Int) -> Int { // [1-100]
        if value > 100 {
            return 100
        } else if value < 1 {
            return 1
        } else {
            return value
        }
    }
    
    static func getBrightnessData(data: String) -> Int {
        let splitData = data.components(separatedBy: ";")
        var brightness: Int = 100
        for key in splitData {
            if key.contains("brightness") {
                if let strValue = key.components(separatedBy: "=").last {
                    if let brightnessOpt = Int(strValue) {
                        brightness = brightnessValueConstraint(brightnessOpt)
                    } else {
                        print("Error parsing Device Data: 'brightness' value is not an Integer value")
                    }
                } else {
                    print("Error parsing Device Data: 'brigtness' parsing failed")
                }
            }
        }
        return brightness
    }

}
