import Foundation
import SwiftUI


class HomeLightViewModel: ObservableObject {
    
    @Published public var locations: [Location] = []

    init() {
        
    }
    
    init(locations: [Location]) {
        self.locations = locations
    }
    
}
