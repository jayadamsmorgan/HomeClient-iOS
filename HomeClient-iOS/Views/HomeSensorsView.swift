import SwiftUI

struct HomeSensorsView: View {
    
    @StateObject var homeSensorsViewModel: HomeSensorsViewModel
    
    init(_ homeSensorsViewModel: HomeSensorsViewModel) {
        _homeSensorsViewModel = StateObject(wrappedValue: homeSensorsViewModel)
    }
    
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
        let homeSensorsViewModel = HomeSensorsViewModel()
        HomeSensorsView(homeSensorsViewModel)
    }
}
