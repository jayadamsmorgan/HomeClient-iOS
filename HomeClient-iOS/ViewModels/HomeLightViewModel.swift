import Foundation
import SwiftUI


class HomeLightViewModel: ObservableObject {
    
    @Published public var locations: [Location] = []

    public static let shared = HomeLightViewModel()
    
    fileprivate init() {
        
    }
    
    init(locations: [Location]) {
        self.locations = locations
    }
    
    public func fetchLocations() {
        
    }
    
}
