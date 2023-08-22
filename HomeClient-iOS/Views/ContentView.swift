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
        .introspect(.tabView, on: .iOS(.v16, .v17)) { tabView in
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemThinMaterial)
            tabView.tabBar.standardAppearance = tabBarAppearance
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
        .onAppear {
            let bedroomLocation = Location(locationName: "Bedroom")
            let bedroomLight = LightDevice(id: 1, name: "Bedroom Light", location: bedroomLocation, data: "", ipAddress: "192.168.1.12", on: false)
            let deskLight = LightDevice(id: 2, name: "Desk Light", location: bedroomLocation, data: "", ipAddress: "192.168.1.13", on: true)
            _ = bedroomLocation.addDevice(bedroomLight)
            _ = bedroomLocation.addDevice(deskLight)
            
            let bathroomLocation = Location(locationName: "Bathroom")
            let bathroomLight = LightDevice(id: 3, name: "Bathroom Light", location: bathroomLocation, data: "", ipAddress: "192.168.1.14", on: false)
            _ = bathroomLocation.addDevice(bathroomLight)
            
            homeLightViewModel.locations = [bedroomLocation, bathroomLocation]
        }
    }
}
