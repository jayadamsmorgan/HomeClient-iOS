import Foundation

class DeviceManager {
    
    var devices: [any Device] = []
    var deviceEntities: [DeviceEntity] = []
    
    public static let receiveThreadLabel = "receiveThreadLabel"
    
    fileprivate static var instance: DeviceManager?
    
    public static func getInstance() -> DeviceManager {
        if instance == nil {
            instance = DeviceManager()
        }
        return instance!
    }
    
    fileprivate init() {
        self.networkDeviceManager = NetworkDeviceManager(UDPServer())
        self.localDeviceManager = LocalDeviceManager(CoreDataService())
        self.receiveThreadInit()
    }
    
    fileprivate let networkDeviceManager: NetworkDeviceManager
    fileprivate let localDeviceManager: LocalDeviceManager
    
    fileprivate func receiveThreadInit() {
        
        let queue = DispatchQueue(label: DeviceManager.receiveThreadLabel, qos: .background)
        
        queue.async {
            while true {
                self.networkDeviceManager.getServerDevices { error, result in
                    if let error = error {
                        print("Cannot get Devices from Server: \(error.message)")
                    } else {
                        self.devices = DeviceFactory.convertToDevices(deviceDTOs: result)
                        self.deviceEntities = DeviceFactory.convertToDeviceEntities(devices: self.devices)
                    }
                }
            }
        }
    }
    
    public func saveDevice(device: any Device) {
        let deviceDTO = DeviceFactory.convertToDeviceDTO(device: device)
        networkDeviceManager.updateServerDevice(device: deviceDTO) { error in
            if let error = error {
                print("Cannot update Device over UDP: \(error.message)")
            }
        }
    }
    
}

private class NetworkDeviceManager {

    private let udpServer: UDPServer

    init(_ udpServer: UDPServer) {
        self.udpServer = udpServer
    }

    public func getServerDevices(_ handleFinish: @escaping (_ error: Error?, _ result: [DeviceDTO]) -> Void) {
        udpServer.receiveUdp { error, result in
            if error != nil {
                handleFinish(error, [])
            } else {
                do {
                    let devices: [DeviceDTO] = try JSONDecoder().decode([DeviceDTO].self, from: result!)
                    handleFinish(nil, devices)
                } catch {
                    // TODO: change UDP_ERROR to SERIALIZATION_ERROR
                    handleFinish(Error("Cannot get Devices: Cannot decode Device JSON Array", .UDP_ERROR), [])
                }
            }
        }
    }

    public func updateServerDevice(device: DeviceDTO, _ handleFinish: @escaping (_ error: Error?) -> Void) {
        do {
            let json = try JSONEncoder().encode(device)
            udpServer.sendUdp(json) { error in
                handleFinish(error)
            }
        } catch {
            handleFinish(Error("Cannot update Device: Cannot encode Device with ID '\(device.id ?? -1)'", .UDP_ERROR))
        }
    }


}

private class LocalDeviceManager {
    
    private let coreDataService: CoreDataService
    
    init(_ coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
    
    public func getLocalDevices() -> (Error?, [DeviceEntity]) {
        if let error = coreDataService.fetchEntity(entityType: .deviceEntity) {
            return (error, [])
        }
        
    }
    
    public func saveDeviceLocally(_ device: DeviceEntity) -> Error? {
        if let error = coreDataService.saveEntity(device) {
            return error
        }
        
    }
    
}
