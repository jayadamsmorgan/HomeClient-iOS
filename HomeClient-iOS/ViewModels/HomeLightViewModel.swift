import Foundation
import SwiftUI


@MainActor class HomeLightViewModel: ObservableObject {
    
    @Published public var locations: [Location] = []

    init() {
        
    }
    
}
