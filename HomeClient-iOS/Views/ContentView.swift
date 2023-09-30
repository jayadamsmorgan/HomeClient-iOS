import SwiftUI
import SwiftUIIntrospect

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeLightView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .onAppear {
                    let bedroomLocation = Location(id: 1, locationName: "Bedroom")
                    let bedroomLight = LightDevice(id: 1,
                                                   name: "Bedroom Light",
                                                   location: bedroomLocation,
                                                   data: "",
                                                   ipAddress: "192.168.1.12",
                                                   on: false,
                                                   brightness: 100)
                    let deskLight = LightDevice(id: 2,
                                                name: "Desk Light",
                                                location: bedroomLocation,
                                                data: "",
                                                ipAddress: "192.168.1.13",
                                                on: true,
                                                brightness: 60)
                    bedroomLocation.devices.append(bedroomLight)
                    bedroomLocation.devices.append(deskLight)
                    
                    let bathroomLocation = Location(id: 2, locationName: "Bathroom")
                    let bathroomLight = LightDevice(id: 3,
                                                    name: "Bathroom Light",
                                                    location: bathroomLocation,
                                                    data: "",
                                                    ipAddress: "192.168.1.14",
                                                    on: false,
                                                    brightness: 100)
                    bathroomLocation.devices.append(bathroomLight)
                    
                    HomeLightViewModel.shared.locations = [bedroomLocation, bathroomLocation]
                }
            HomeSensorsView()
                .tabItem {
                    Image(systemName: "sensor")
                    Text("Sensors")
                }
            AutomationsView()
                .tabItem {
                    Image(systemName: "deskclock")
                    Text("Automations")
                }
            SettingsView()
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
        ContentView()
    }
}
