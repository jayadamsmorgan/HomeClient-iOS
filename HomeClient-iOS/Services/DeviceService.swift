import Foundation
import Siesta

class DeviceService {
    
    private let networkManager = NetworkManager.shared
    
    public static let shared = DeviceService()
    
    init() {
        
    }
    
    var timer: Timer?
    
    func startLocationRequests() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.getLocations { locations, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                HomeLightViewModel.shared.locations = locations
            }
        }
    }
    
    func stopLocationRequests() {
        timer?.invalidate()
        timer = nil
    }
    
    func getDeviceById(id: Int, handleFinish: @escaping ( _ device: (any Device)?, _ error: Error?) -> Void) {
        let request = networkManager.get(resource: "/devices/\(id)")
        request?
            .onSuccess { callback in
                do {
                    let deviceWrapper = try JSONDecoder().decode(DeviceWrapper.self, from: callback.content as! Data)
                    let device = deviceWrapper.device
                    handleFinish(device, nil)
                } catch {
                    handleFinish(nil, error)
                }
            }
            .onFailure({ callback in
                handleFinish(nil, callback)
            })
    }
    
    func getDevicesByLocation(location: String, handleFinish: @escaping ( _ devices: [any Device], _ error: Error?) -> Void) {
        let request = networkManager.get(resource: "/location/\(location)/devices")
        request?
            .onSuccess { callback in
                do {
                    let deviceWrappers = try JSONDecoder().decode([DeviceWrapper].self, from: callback.content as! Data)
                    let devices = deviceWrappers.map { $0.device }
                    handleFinish(devices, nil)
                } catch {
                    handleFinish([], error)
                }
            }
            .onFailure { callback in
                handleFinish([], callback)
            }
    }
    
    func getDevices(handleFinish: @escaping ( _ devices: [any Device], _ error: Error?) -> Void) {
        let request = networkManager.get(resource: "/devices")
        request?
            .onSuccess { callback in
                do {
                    let deviceWrappers = try JSONDecoder().decode([DeviceWrapper].self, from: callback.content as! Data)
                    let devices = deviceWrappers.map { $0.device }
                    handleFinish(devices, nil)
                } catch {
                    handleFinish([], error)
                }
            }
            .onFailure { callback in
                handleFinish([], callback)
            }
    }
    
    func getLocations(handleFinish: @escaping ( _ locations: [Location], _ error: Error?) -> Void) {
        let request = networkManager.get(resource: "/locations")
        request?
            .onSuccess { callback in
                do {
                    let locations = try JSONDecoder().decode([Location].self, from: callback.content as! Data)
                    handleFinish(locations, nil)
                } catch {
                    handleFinish([], error)
                }
            }
            .onFailure { callback in
                handleFinish([], callback)
            }
    }
    
}
