import Foundation

class DeviceManager {
    
    public static let receiveThreadLabel = "receiveThreadLabel"
    
    fileprivate static var instance: DeviceManager?
    
    public static func getInstance() -> DeviceManager {
        if instance == nil {
            instance = DeviceManager()
        }
        return instance!
    }
    
    fileprivate init() {
        self.networkDeviceManager = NetworkDeviceManager(UDPService())
        self.locationFactory = LocationFactory.getInstance()
        self.receiveThreadInit()
    }
    
    fileprivate let networkDeviceManager: NetworkDeviceManager
    fileprivate let locationFactory: LocationFactory
    
    fileprivate func receiveThreadInit() {
        
        let queue = DispatchQueue(label: DeviceManager.receiveThreadLabel, qos: .background)
        
        queue.async {
            while true {
                self.networkDeviceManager.getServerDevices { error, result in
                    if let error = error {
                        print("Cannot get Devices from Server: \(error.message)")
                    } else {
                        let deviceFactory = DeviceFactory.getInstance()
                        deviceFactory.dtosToDevices(deviceDTOs: result)
                    }
                }
            }
        }
    }
    
}

private class NetworkDeviceManager {

    private let udpService: UDPService

    init(_ udpService: UDPService) {
        self.udpService = udpService
    }

    public func getServerDevices(_ handleFinish: @escaping (_ error: Error?, _ result: [DeviceDTO]) -> Void) {
        udpService.receiveUdp { error, result in
            if error != nil {
                handleFinish(error, [])
            } else {
                do {
                    let devices: [DeviceDTO] = try JSONDecoder().decode([DeviceDTO].self, from: result!)
                    handleFinish(nil, devices)
                } catch {
                    handleFinish(Error("Cannot get Devices: Cannot decode Device JSON Array", .SERIALIZATION_ERROR), [])
                }
            }
        }
    }

    public func updateServerDevice(device: DeviceDTO, _ handleFinish: @escaping (_ error: Error?) -> Void) {
        do {
            let json = try JSONEncoder().encode(device)
            udpService.sendUdp(json) { error in
                handleFinish(error)
            }
        } catch {
            handleFinish(Error("Cannot update Device: Cannot encode Device with ID '\(device.id ?? -1)'", .SERIALIZATION_ERROR))
        }
    }


}

