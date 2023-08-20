import Foundation

class LocationFactory {
    
    private init() {
        self.locationEntities = CoreDataService.getInstance().getLocationEntities()
        entitiesToLocations()
    }
    
    private var locations: [Location] = []
    private var locationEntities: [LocationEntity] = []
    
    static private var instance: LocationFactory?
    
    static func getInstance() -> LocationFactory {
        if instance == nil {
            instance = LocationFactory()
        }
        return instance!
    }
    
    fileprivate func entitiesToLocations() {
        var locationsTemp: [Location] = []
        for locationEntity in locationEntities {
            if let locationName = locationEntity.locationName {
                let location = Location(locationName: locationName)
                locationsTemp.append(location)
            }
        }
        locations = locationsTemp
    }
    
    func getLocations() -> [Location] {
        locations
    }
    
    func removeLocation(_ locationName: String) {
        locations.removeAll(where: { $0.locationName == locationName })
    }
    
    func isLocationPresent(_ locationName: String) -> Bool {
        return locations.contains(where: { $0.locationName == locationName })
    }
    
    func getLocationByName(_ locationName: String) -> Location? {
        return locations.first(where: { $0.locationName == locationName })
    }
    
    func createNewLocation(_ locationName: String) -> Location? {
        
        if isLocationPresent(locationName) {
            return nil
        }
        
        let newLocation = Location(locationName: locationName)
        
        let coreDataService = CoreDataService.getInstance()
        let newLocationEntity = LocationEntity(context: coreDataService.getContext())
        if let error = coreDataService.save() {
            print(error)
        }
        
        locations.append(newLocation)
        locationEntities = coreDataService.getLocationEntities()
        
        return newLocation
    }
    
}
