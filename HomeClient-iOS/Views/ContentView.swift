import SwiftUI
import SwiftUIIntrospect

struct ContentView: View {
    
    var homeLightViewModel: HomeLightViewModel
    var settingsViewModel: SettingsViewModel
    var homeSensorsViewModel: HomeSensorsViewModel
    
    var body: some View {
        TabView {
            HomeLightView(homeLightViewModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            HomeSensorsView(homeSensorsViewModel)
                .tabItem {
                    Image(systemName: "sensor")
                    Text("Sensors")
                }
            SettingsView(settingsViewModel)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .introspect(.tabView, on: .iOS(.v15, .v16, .v17)) { tabView in
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabView.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let homeLightViewModel = HomeLightViewModel()
        let settingsViewModel = SettingsViewModel()
        let homeSensorsViewModel = HomeSensorsViewModel()
        ContentView(homeLightViewModel: homeLightViewModel,
                    settingsViewModel: settingsViewModel,
                    homeSensorsViewModel: homeSensorsViewModel)
    }
}
