import SwiftUI

struct HomeSensorsView: View {
    
    @StateObject var homeSensorsViewModel = HomeSensorsViewModel.shared
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
            }
            .navigationTitle("Sensors")
            .refreshable {
                
            }
            .background {
                Background()
            }
        }
    }
}

struct HomeSensorsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSensorsView()
    }
}
