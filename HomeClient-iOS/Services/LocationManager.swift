import Foundation

class LocationManager {
    
    static let shared = LocationManager()
    
    private var locations: [Location] = []
    
    fileprivate init() {
        
    }
    
    func getLocationByName(_ name: String) -> Location? {
        locations.filter({ $0.locationName == name }).first
    }
    
}
