import Foundation

class LocationFactory {
    
    private init() {
        
    }
    
    private var locations: Set<Location> = []
    
    static private var instance: LocationFactory?
    
    static func getInstance() -> LocationFactory {
        if instance == nil {
            instance = LocationFactory()
        }
        return instance!
    }
    
    func getLocations() -> [Location] {
        Array(locations)
    }
    
    func addLocation(_ newLocation: Location) -> Bool {
        if isLocationPresent(newLocation) {
            return false
        }
        locations.insert(newLocation)
        return true
    }
    
    func removeLocation(_ location: Location) -> Bool {
        if !isLocationPresent(location) {
            return false
        }
        locations.remove(location)
        return true
    }
    
    func isLocationPresent(_ location: Location) -> Bool {
        return locations.contains(where: { $0.locationName == location.locationName } )
    }
    
    func isLocationPresent(_ locationName: String) -> Bool {
        return locations.contains(where: { $0.locationName == locationName })
    }
    
    func getLocationByName(_ locationName: String) -> Location {
        if let location = locations.first(where: { $0.locationName == locationName }) {
            return location
        }
        
        // TODO: Create new location
    }
    
}
