class DeviceFactory {
    
    static let shared = DeviceFactory()
    
    fileprivate var registry = [String : BasicDevice.Type]()
    
    fileprivate init() {
        // BasicDevice
        register(deviceType: "BasicDevice", deviceClass: BasicDevice.self)
        
        // LightDevices
        register(deviceType: "LightDevice", deviceClass: LightDevice.self)
        register(deviceType: "lights.LightDevice", deviceClass: LightDevice.self)

        register(deviceType: "RGBLightDevice", deviceClass: RGBLight.self)
        register(deviceType: "lights.RGBLightDevice", deviceClass: RGBLight.self)
    }
    
    fileprivate func register(deviceType: String, deviceClass: BasicDevice.Type) {
        registry[deviceType] = deviceClass
    }
    
    func create(deviceType: String, from decoder: Decoder) throws -> BasicDevice? {
        guard let type = registry[deviceType] else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Device type \(deviceType) not registered"))
        }
        return try type.init(from: decoder)
    }
}
