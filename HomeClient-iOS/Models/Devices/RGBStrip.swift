import Foundation

class RGBStrip: RGBLight {
    
    @Published private var stripData: StripData
    
    override init(id: Int, name: String, location: Location, data: String, ipAddress: String, on: Bool) {
        self.stripData = RGBStrip.getStripData(data: data)
        super.init(id: id, name: name, location: location, data: data, ipAddress: ipAddress, on: on)
    }
    
    public static func getStripData(data: String) -> StripData {
        let splitData = data.split(separator: ";")
        var speed: Int?
        var stripModeType: StripModeType?
        var length: Int?
        for key in splitData {
            if key.contains("length") {
                if let strValue = key.split(separator: "=").last {
                    if let lengthOpt = Int(strValue) {
                        length = lengthOpt
                    } else {
                        print("Error parsing Device Data: 'length' is not an Integer value. Using default value '100'.")
                        length = 100;
                    }
                } else {
                    print("Error parsing Device Data: 'length' parsing failed. Using default value '100'.")
                    length = 100;
                }
            }
            if key.contains("speed") {
                if let strValue = key.split(separator: "=").last {
                    if let speedOpt = Int(strValue) {
                        speed = speedOpt
                    } else {
                        print("Error parsing Device Data: 'speed' is not an Integer value. Using default value '1'.")
                        speed = 1;
                    }
                } else {
                    print("Error parsing Device Data: 'speed' parsing failed. Using default value '1'.")
                    speed = 1;
                }
            }
            if key.contains("stripMode") {
                if let strValue = key.split(separator: "=").last {
                    if let stripModeTypeOpt = StripModeType(rawValue: String(strValue)) {
                        stripModeType = stripModeTypeOpt
                    } else {
                        print("Error parsing Device Data: 'stripMode' is not a StripModeType value. Using default value '.stripModeStatic'.")
                    }
                } else {
                    print("Error parsing Device Data: 'stripMode' parsing failed. Using default value '.stripModeStatic'.")
                }
            }
        }
        if length == nil {
            print("Error parsing Device Data: Device Data does not contain 'length'. Using default value '100'.")
        }
        if speed == nil {
            print("Error parsing Device Data: Device Data does not contain 'speed'. Using default value '1'.")
        }
        if stripModeType == nil {
            print("Error parsing Device Data: Device Data does not contain 'stripMode'. Using default value '.stripModeStatic'.")
        }
        return StripData(stripModeType: stripModeType ?? .stripModeStatic, speed: speed ?? 1, length: length ?? 100)
        
    }
    
    struct StripData {
        
        var stripModeType: StripModeType
        
        var speed: Int
        
        var length: Int
        
        // ??? may have more properties
        
    }

    enum StripModeType: String {
        
        case stripModeStatic = "STATIC"
            
        case stripModeRainbow = "RAINBOW"
            
        case stripModeSnake = "SNAKE"
        
        case stripModeBreathing = "BREATHE"
    }
    
}

