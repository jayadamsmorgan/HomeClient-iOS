import Foundation

class RGBLight: LightDevice {
    
    // RGB value range: 0-255 (Int)
    
    @Published private var red: Int = 0
    @Published private var green: Int = 0
    @Published private var blue: Int = 0
    
    override init(id: Int, name: String, location: Location, data: String, ipAddress: String, on: Bool) {
        super.init(id: id, name: name, location: location, data: data, ipAddress: ipAddress, on: on)
        (red, green, blue, _) = RGBLight.getRGBWData(data: data)
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
        self.red = RGBLight.rgbwValueConstraint(red)
    }
    
    func setGreen(_ green: Int) {
        self.green = RGBLight.rgbwValueConstraint(green)
    }
    
    func setBlue(_ blue: Int) {
        self.blue = RGBLight.rgbwValueConstraint(blue)
    }
    
    private static func rgbwValueConstraint(_ value: Int) -> Int { // [0-255]
        if value > 255 {
            return 255
        } else if value < 0 {
            return 0
        } else {
            return value
        }
    }
    
    static func getRGBWData(data: String) -> (red: Int, green: Int, blue: Int, white: Int) {
        let splitData = data.split(separator: ";")
        var red: Int = 0
        var green: Int = 0
        var blue: Int = 0
        var white: Int = 0
        for key in splitData {
            if key.contains("red") {
                if let strValue = key.split(separator: "=").last {
                    if let redOpt = Int(strValue) {
                        red = rgbwValueConstraint(redOpt)
                    } else {
                        print("Error parsing Device Data: 'red' value is not an Integer value")
                    }
                } else {
                    print("Error parsing Device Data: 'red' parsing failed")
                }
            }
            if key.contains("green") {
                if let strValue = key.components(separatedBy: "=").last {
                    if let greenOpt = Int(strValue) {
                        green = rgbwValueConstraint(greenOpt)
                    } else {
                        print("Error parsing Device Data: 'green' value is not an Integer value")
                    }
                } else {
                    print("Error parsing Device Data: 'green' parsing failed")
                }
            }
            if key.contains("blue") {
                if let strValue = key.components(separatedBy: "=").last {
                    if let blueOpt = Int(strValue) {
                        blue = rgbwValueConstraint(blueOpt)
                    } else {
                        print("Error parsing Device Data: 'blue' value is not an Integer value")
                    }
                } else {
                    print("Error parsing Device Data: 'blue' parsing failed")
                }
            }
            if key.contains("white") {
                if let strValue = key.components(separatedBy: "=").last {
                    if let whiteOpt = Int(strValue) {
                        white = rgbwValueConstraint(whiteOpt)
                    } else {
                        print("Error parsing Device Data: 'white' value is not an Integer value")
                    }
                } else {
                    print("Error parsing Device Data: 'white' parsing failed")
                }
            }
        }
        return (red, green, blue, white)
    }
    
}
