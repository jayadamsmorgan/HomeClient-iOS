import Foundation
import CoreData

class CoreDataService {
    
    fileprivate let container: NSPersistentContainer
    
    fileprivate var savedDeviceEntities: [DeviceEntity] = []
    fileprivate var savedLocationEntities: [LocationEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "HomeClientCoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading CoreData: \(error)")
            }
        }
        
        if let error = fetchEntities() {
            print(error)
        }
        
    }
    
    public func fetchEntities() -> Error? {
        if let error = fetchEntity(entityType: .deviceEntity) {
            return error
        }
        if let error = fetchEntity(entityType: .locationEntity) {
            return error
        }
        return nil
    }
    
    public func fetchEntity(entityType: HomeClientCoreDataEntity) -> Error? {
        
        switch entityType {
            
        case .deviceEntity:
            let request = NSFetchRequest<DeviceEntity>(entityName: entityType.rawValue)
            do {
                savedDeviceEntities = try container.viewContext.fetch(request)
                return nil
            } catch let error {
                return Error(error.localizedDescription, .DEFAULT_ERROR)
            }
            
        case .locationEntity:
            let request = NSFetchRequest<LocationEntity>(entityName: entityType.rawValue)
            do {
                savedLocationEntities = try container.viewContext.fetch(request)
                return nil
            } catch let error {
                return Error(error.localizedDescription, .DEFAULT_ERROR)
            }
        }
    }
    
    func saveEntity<T>(_ entity: T) -> Error? where T: NSManagedObject {
        
    }
    
    func getDeviceEntities() -> [DeviceEntity] {
        savedDeviceEntities
    }
    
    func getLocationEntities() -> [LocationEntity] {
        savedLocationEntities
    }
}

enum HomeClientCoreDataEntity: String {
    
    case deviceEntity = "DeviceEntity"
    
    case locationEntity = "LocationEntity"
    
}


