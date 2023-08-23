import SwiftUI

struct AutomationsView: View {
    
    @StateObject var automationsViewModel: AutomationsViewModel
    
    init(_ automationsViewModel: AutomationsViewModel) {
        _automationsViewModel = StateObject(wrappedValue: automationsViewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
            }
            .navigationTitle("Automations")
            .background {
                Background()
            }
        }
    }
}

struct AutomationsView_Previews: PreviewProvider {
    static var previews: some View {
        AutomationsView(AutomationsViewModel())
    }
}
