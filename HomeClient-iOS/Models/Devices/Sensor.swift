import Foundation

struct Sensor: Device {
    
    mutating func changeLocation(newLocation: Location) {
        self.location = newLocation
        _ = newLocation.addDevice(self)
    }
    
    var id: Int
    
    var name: String
    
    internal var location: Location
    
    var ipAddress: String
    
    var data: String
    
    var on: Bool
    
}

struct SensorValue {
    let sensorType: SensorType
    let sensorValue: String
}

enum SensorType: String {
    case temperatureSensor = "temp"
    case humiditySensor = "humi"
    case carbonOxygenSensor = "caox"
    //...
}

extension Sensor {
    
    func parseSensorValues() -> (Error?, [SensorValue]) {
        let args = data.split(separator: ";")
        
        let error: Error?
        let value: SensorValue?
        
        switch args[0] {
            
        case SensorType.carbonOxygenSensor.rawValue:
            (error, value) = getCOSensorData(args: Array(args))
            
        case SensorType.temperatureSensor.rawValue:
            (error, value) = getTempSensorData(args: args)
            
        case SensorType.humiditySensor.rawValue:
            (error, value) = getHumiditySensorData(args: args)
            
        default:
            return (Error("Cannot get Sensor Data: data is corrupt", .DEFAULT_ERROR), [])
            
        }
        
        if value != nil {
            return (nil, [value!])
        }
        return (error, [])
    }
    
    private func getCOSensorData(args: [String.SubSequence]) -> (Error?, SensorValue?) {
        return (Error("Not yet implemented", .DEFAULT_ERROR), nil)
    }
    
    private func getTempSensorData(args: [String.SubSequence]) -> (Error?, SensorValue?) {
        return (Error("Not yet implemented", .DEFAULT_ERROR), nil)
    }
    
    private func getHumiditySensorData(args: [String.SubSequence]) -> (Error?, SensorValue?) {
        return (Error("Not yet implemented", .DEFAULT_ERROR), nil)
    }
    
}
