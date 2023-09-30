import SwiftUI

struct SettingsView: View {
    
    @StateObject private var settingsViewModel = SettingsViewModel.shared
    
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
        SettingsView()
    }
}
