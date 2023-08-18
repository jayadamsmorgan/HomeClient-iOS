import Foundation
import SwiftUI

@MainActor class HomeSensorsViewModel: ObservableObject {
    
    @Published var sensors: [Sensor] = []
    
    init() {
        
    }
    
}
