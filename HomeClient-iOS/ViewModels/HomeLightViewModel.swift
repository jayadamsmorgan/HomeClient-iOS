import Foundation
import SwiftUI


class HomeLightViewModel: ObservableObject {
    
    @Published public var locations: [Location] = []

    init() {
        
    }
    
    init(locations: [Location]) {
        self.locations = locations
    }
    
    public func toggleLightDevice(_ locationIndex: Int, _ deviceIndex: Int) {
        withAnimation {
            locations[locationIndex].lightDevices[deviceIndex].on.toggle()
        }
    }
    
}
