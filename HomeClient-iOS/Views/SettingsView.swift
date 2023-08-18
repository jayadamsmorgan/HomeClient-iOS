import SwiftUI

struct SettingsView: View {
    
    @StateObject private var settingsViewModel: SettingsViewModel
    
    init(_ settingsViewModel: SettingsViewModel) {
        _settingsViewModel = StateObject(wrappedValue: settingsViewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
            }
            .navigationTitle("Settings")
            .background {
                Background()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(SettingsViewModel())
    }
}
