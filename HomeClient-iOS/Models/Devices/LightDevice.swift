import Foundation

class LightDevice: BasicDevice {
    
    @Published private var brightness: Int = 100
    
    override init(id: Int, name: String, location: Location, data: String, ipAddress: String, on: Bool) {
        super.init(id: id, name: name, location: location, data: data, ipAddress: ipAddress, on: on)
        brightness = getBrightnessData(data: data)
    }
    
    var getBrightness: Int {
        brightness
    }
    
    func setBrightness(_ value: Int) {
        if value > 100 {
            brightness = 100
        } else if value < 0 {
            brightness = 0
        } else {
            brightness = value
        }
    }
    
    func getBrightnessData(data: String) -> Int {
        let splitData = data.components(separatedBy: ";")
        var brightness: Int = 100
        for key in splitData {
            if key.contains("brightness") {
                if let strValue = key.components(separatedBy: "=").last {
                    if var brightnessOpt = Int(strValue) {
                        if brightnessOpt > 100 {
                            brightnessOpt = 100
                        }
                        if brightnessOpt < 0 {
                            brightnessOpt = 0
                        }
                        brightness = brightnessOpt
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
