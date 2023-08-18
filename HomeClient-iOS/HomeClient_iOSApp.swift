import SwiftUI

@main
struct HomeClient_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(homeLightViewModel: HomeLightViewModel(),
                        settingsViewModel: SettingsViewModel(),
                        homeSensorsViewModel: HomeSensorsViewModel())
        }
    }
}
