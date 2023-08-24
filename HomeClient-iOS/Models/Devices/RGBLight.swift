import Foundation

class RGBLight: LightDevice {
    
    var red: Int = 0
    var green: Int = 0
    var blue: Int = 0
    
    override init(id: Int, name: String, location: Location, data: String, ipAddress: String, on: Bool) {
        super.init(id: id, name: name, location: location, data: data, ipAddress: ipAddress, on: on)
        (red, green, blue, _) = getRGBWData(data: data)
    }
    
    func getRGBWData(data: String) -> (red: Int, green: Int, blue: Int, white: Int) {
        let splitData = data.components(separatedBy: ";")
        var red: Int = 0
        var green: Int = 0
        var blue: Int = 0
        var white: Int = 0
        for key in splitData {
            if key.contains("red") {
                if let strValue = key.components(separatedBy: "=").last {
                    if let redOpt = Int(strValue) {
                        red = redOpt
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
                        green = greenOpt
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
                        blue = blueOpt
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
                        white = whiteOpt
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
