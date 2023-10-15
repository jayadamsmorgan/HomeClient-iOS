import SwiftUI
import SwiftUIIntrospect

struct ContentView: View {
    
    @ObservedObject var loginViewModel = LoginViewModel.shared
    
    init() {
        let _ = TokenService.shared.retrieveToken()
        let tokenState = TokenService.shared.checkTokenExpiration()
        switch tokenState {
        case .NO_TOKEN_AVAILABLE:
            print("No Token Available")
            loginViewModel.needsLogin = true
        case .EXPIRED:
            print("Token expired")
            loginViewModel.needsLogin = true
        case .ABOUT_TO_EXPIRE:
            print("Token is about to expire")
            // TODO token renewal
            loginViewModel.needsLogin = false
        case .NON_EXPIRED:
            print("Token is not expired")
            loginViewModel.needsLogin = false
        }
    }
    
    var body: some View {
        if loginViewModel.needsLogin {
            LoginView()
        } else {
            TabView {
                HomeLightView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .onAppear {
                let bedroomLocation = Location(locationName: "Bedroom")
                let bedroomLight = LightDevice(id: "1",
                                               name: "Bedroom Light",
                                               on: false,
                                               brightness: 100)
                let deskLight = LightDevice(id: "2",
                                            name: "Desk Light",
                                            on: true,
                                            brightness: 60)
                bedroomLocation.devices.append(bedroomLight)
                bedroomLocation.devices.append(deskLight)
                
                let bathroomLocation = Location(locationName: "Bathroom")
                let bathroomLight = LightDevice(id: "3",
                                                name: "Bathroom Light",
                                                on: false,
                                                brightness: 100)
                bathroomLocation.devices.append(bathroomLight)
                
                HomeLightViewModel.shared.locations = [bedroomLocation, bathroomLocation]
            }
    }
}
