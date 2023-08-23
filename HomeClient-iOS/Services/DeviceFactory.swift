import Foundation

class DeviceFactory {
    
    private init() {
        self.coreDataService = CoreDataService.getInstance()
        self.deviceEntities = coreDataService.getDeviceEntities()
        entitiesToDevices()
    }
    
    private var coreDataService: CoreDataService
    
    private var devices: [any Device] = []
    private var deviceEntities: [DeviceEntity] = []
    
    static private var instance: DeviceFactory?
    
    public static func getInstance() -> DeviceFactory {
        if instance == nil {
            instance = DeviceFactory()
        }
        return instance!
    }
    
    fileprivate func entitiesToDevices() {
        var devicesTemp: [any Device] = []
        for deviceEntity in deviceEntities {
            
            var location = LocationFactory.getInstance().getLocationByName(deviceEntity.locationName ?? "No Location")
            if location == nil {
                location = LocationFactory.getInstance().createNewLocation(deviceEntity.locationName ?? "No Location")
            }
            switch deviceEntity.type {
                
            case DeviceType.lightDevice.rawValue:
                let device = LightDevice(id: Int(deviceEntity.id),
                                         name: deviceEntity.name ?? "NONAME",
                                         location: location!,
                                         data: deviceEntity.data ?? "",
                                         ipAddress: deviceEntity.ipAddress ?? "",
                                         on: false)
                devicesTemp.append(device)
                
            case DeviceType.sensor.rawValue:
                let device = Sensor(id: Int(deviceEntity.id),
                                    name: deviceEntity.name ?? "NONAME",
                                    location: location!,
                                    ipAddress: deviceEntity.ipAddress ?? "",
                                    data: deviceEntity.data ?? "",
                                    on: false)
                devicesTemp.append(device)
                
            case DeviceType.rgbLight.rawValue:
                let device = RGBLight(id: Int(deviceEntity.id),
                                      name: deviceEntity.name ?? "NONAME",
                                      location: location!,
                                      data: deviceEntity.data ?? "",
                                      ipAddress: deviceEntity.ipAddress ?? "",
                                      on: false)
                devicesTemp.append(device)
                
            default:
                print("Cannot convert DeviceEntity to Device: DeviceType is not yet supported")
            }
        }
        devices = devicesTemp
    }
    
    func dtosToDevices(deviceDTOs: [DeviceDTO]) {
        for deviceDTO in deviceDTOs {
            if deviceDTO.id == nil {
                print("Cannot convert DeviceDTO to Device: 'id' is nil")
                continue
            }
            if deviceDTO.location == nil {
                print("Cannot convert DeviceDTO to Device: 'location' is nil")
                continue
            }
            if deviceDTO.ipAddress == nil {
                print("Cannot convert DeviceDTO to Device: 'ipAddress' is nil")
                continue
            }
            if deviceDTO.type == nil {
                print("Cannot convert DeviceDTO to Device: 'type' is nil")
                continue
            }
            
            var deviceEntity = deviceEntities.first(where: { Int($0.id) == deviceDTO.id! })
            if deviceEntity == nil {
                deviceEntity = DeviceEntity(context: coreDataService.getContext())
                deviceEntity!.id = Int64(deviceDTO.id!)
            }
            
            deviceEntity!.data = deviceDTO.data
            deviceEntity!.ipAddress = deviceDTO.ipAddress
            deviceEntity!.name = deviceDTO.name
            deviceEntity!.type = deviceDTO.type
            
            if deviceEntity!.locationName != deviceDTO.location! {
                deviceEntity!.locationName = deviceDTO.location
                var locationEntity = LocationFactory.getInstance().getLocationByName(deviceDTO.location!)
                if locationEntity == nil {
                    locationEntity = LocationFactory.getInstance().createNewLocation(deviceDTO.location!)
                }
                deviceEntity!.deviceLocation = coreDataService.getLocationEntities().first(where: { $0.locationName == deviceDTO.location! })
            }
            
            if let error = coreDataService.save() {
                print(error)
            }
            
        }
        deviceEntities = coreDataService.getDeviceEntities()
        entitiesToDevices()
    }
    
    func getDevices() -> [any Device] {
        devices
    }
    
    func removeDevice(deviceId: Int) {
        devices.removeAll(where: { $0.id == deviceId })
    }
    
    func isDevicePresent(deviceId: Int) -> Bool {
        return devices.contains(where: { $0.id == deviceId })
    }
    
    func getDeviceById(deviceId: Int) -> (any Device)? {
        return devices.first(where: { $0.id == deviceId })
    }
    
    func createDevice(deviceDTO: DeviceDTO) -> (any Device)? {
        
        if deviceDTO.id == nil {
            print("Cannot parse one of the DeviceDTOs: id is nil")
            return nil
        }
        if deviceDTO.location == nil {
            print("Cannot parse one of the DeviceDTOs: location is nil")
            return nil
        }
        if deviceDTO.ipAddress == nil {
            print("Cannot parse one of the DeviceDTOs: ipAddress is nil")
            return nil
        }
        
        let locationFactory = LocationFactory.getInstance()
        
        if let type = deviceDTO.type {
            
            var location = locationFactory.getLocationByName(deviceDTO.location!)
            
            if location == nil {
                location = locationFactory.createNewLocation(deviceDTO.location!)
            }
            
            var device: (any Device)?
            
            switch type {
            
            case DeviceType.lightDevice.rawValue:
                
                device = LightDevice(id: deviceDTO.id!,
                                         name: deviceDTO.name ?? "NONAME",
                                         location: location!,
                                         data: deviceDTO.data ?? "",
                                         ipAddress: deviceDTO.ipAddress!,
                                         on: deviceDTO.on ?? false)
                
            case DeviceType.sensor.rawValue:
                
                device = Sensor(id: deviceDTO.id!,
                                    name: deviceDTO.name ?? "NONAME",
                                    location: location!,
                                    ipAddress: deviceDTO.ipAddress!,
                                    data: deviceDTO.data ?? "",
                                    on: deviceDTO.on ?? false)
                
            case DeviceType.rgbLight.rawValue:
                
                device = RGBLight(id: deviceDTO.id!,
                                  name: deviceDTO.name ?? "NONAME",
                                  location: location!,
                                  data: deviceDTO.data ?? "",
                                  ipAddress: deviceDTO.ipAddress!,
                                  on: deviceDTO.on ?? false)
                
            default:
                // TODO: implement other DeviceTypes
                print("Cannot create new Device from DeviceDTO: DeviceType is not yet supported")
                return nil
            }
            
            devices.append(device!)
            
            let deviceEntity = DeviceEntity(context: coreDataService.getContext())
            deviceEntity.id = Int64(device!.id)
            deviceEntity.name = device!.name
            deviceEntity.data = device!.data
            deviceEntity.ipAddress = device!.ipAddress
            deviceEntity.locationName = device!.location.locationName
            deviceEntity.type = DeviceType.lightDevice.rawValue
            
            let locationEntity = coreDataService.getLocationEntities().first(where: { $0.locationName == device!.location.locationName })
            deviceEntity.deviceLocation = locationEntity
            
            if let error = coreDataService.save() {
                print(error)
            }
            
            deviceEntities = coreDataService.getDeviceEntities()
            
            return device
        }
        return nil
    }
    
}
