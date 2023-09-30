import Foundation
import CoreData

class CoreDataService {
    
    fileprivate let container = NSPersistentContainer(name: "HomeClientCoreDataContainer")
    
    fileprivate var savedDeviceEntities: [DeviceEntity] = []
    fileprivate var savedLocationEntities: [LocationEntity] = []
    
    public static let shared = CoreDataService()
    
    private init() {
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
                
            }
            
        case .locationEntity:
            let request = NSFetchRequest<LocationEntity>(entityName: entityType.rawValue)
            do {
                savedLocationEntities = try container.viewContext.fetch(request)
                return nil
            } catch let error {
                
            }
        }
        return nil
    }
    
    func save() -> Error? {
        do {
            try container.viewContext.save()
            if let error = fetchEntities() {
                return error
            }
        } catch let error {
            
        }
        return nil
    }
    
    func getContext() -> NSManagedObjectContext {
        return container.viewContext
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


