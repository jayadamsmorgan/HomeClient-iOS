import SwiftUI

struct HomeLightView: View {
    
    @StateObject private var homeLightViewModel = HomeLightViewModel.shared
    
    @State private var isLocationSheetPresented = false
    @State private var sheetLocationIndex: Int = 0
    
    init() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        if let window = windowScene?.windows.first {
            window.backgroundColor = UIColor(Color("darkPink"))
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                if (homeLightViewModel.locations.count == 0) {
                    Color.clear
                    Text("No devices in your home yet")
                        .padding(.top, 250)
                } else {
                    VStack {
                        ForEach(0..<homeLightViewModel.locations.count, id: \.self) { locationIndex in
                            if homeLightViewModel.locations[locationIndex].devices.count == 0 {
                                Color.clear
                            } else {
                                VStack(alignment: .leading) {
                                    
                                    Button {
                                        sheetLocationIndex = locationIndex
                                        isLocationSheetPresented = true
                                    } label: {
                                        HStack {
                                            Text(homeLightViewModel.locations[locationIndex].locationName)
                                                .font(.title)
                                                .foregroundColor(Color.primary)
                                            Image(systemName: "chevron.right")
                                        }
                                        .padding()
                                        .padding(.leading, 7)
                                    }
                                    
                                    HStack {
                                        TurnAllInLocationButton(locationIndex: locationIndex, on: true)
                                        TurnAllInLocationButton(locationIndex: locationIndex, on: false)
                                    }
                                    .padding(.bottom, 20)
                                    .padding(.leading, 20)
                                    
                                    
                                    LazyVGrid(columns: [.init(.adaptive(minimum: 200), spacing: -15)],  spacing: 18) {
                                        ForEach(0..<homeLightViewModel.locations[locationIndex].devices.count, id:\.self) { deviceIndex in
                                            if homeLightViewModel.locations[locationIndex].devices[deviceIndex] is LightDevice {
                                                LightDeviceCardView(lightDevice: homeLightViewModel.locations[locationIndex].devices[deviceIndex] as! LightDevice)
                                            }
                                        }
                                    }
                                    .padding(.bottom, 20)
                                    
                                }
                            }
                            
                        }
                    }
                }
            }
            .refreshable {
                homeLightViewModel.fetchLocations()
            }
            .navigationTitle("Home Lights")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // TODO: Go to DeviceAddingView
                    } label: {
                        Image(systemName: "plus")
                            .padding(5)
                            .background {
                                Circle()
                                    .foregroundStyle(.thickMaterial)
                            }
                    }
                    .offset(x: -10)
                }
            }
            .background {
                Background()
            }
        }
        .sheet(isPresented: $isLocationSheetPresented) {
            ZStack(alignment: .topTrailing) {
                LocationView(sheetLocationIndex)
                    .onAppear {
                        
                    }
                Button {
                    isLocationSheetPresented = false
                } label: {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background {
                            Circle()
                                .foregroundStyle(.thickMaterial)
                        }
                }
                .padding(.trailing, 30)
                .padding(.top, 30)
            }
        }
        .introspect(.navigationStack, on: .iOS(.v16, .v17)) { navStack in
            let navbarAppearance = UINavigationBarAppearance()
            navbarAppearance.configureWithDefaultBackground()
            navbarAppearance.backgroundEffect = UIBlurEffect(style: .systemThinMaterial)
            navStack.navigationBar.standardAppearance = navbarAppearance
        }
    }
}

struct TurnAllInLocationButton: View {
    
    let locationIndex: Int
    let on: Bool
    
    var body: some View {
        Button {
            for index in 0..<HomeLightViewModel.shared.locations[locationIndex].devices.count {
                if HomeLightViewModel.shared.locations[locationIndex].devices[index] is LightDevice {
                    withAnimation {
                        HomeLightViewModel.shared.locations[locationIndex].devices[index].on = on
                    }
                }
            }
        } label: {
            Text(on ? "Turn all on" : "Turn all off")
                .font(.headline)
                .padding()
                .foregroundColor(Color.primary)
                .background {
                    Rectangle()
                        .foregroundStyle(.ultraThinMaterial)
                        .cornerRadius(25)
                }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeLightView()
            .onAppear {
                let bedroomLocation = Location(id: 1, locationName: "Bedroom")
                let bedroomLight = LightDevice(id: 1,
                                               name: "Bedroom Light",
                                               on: false,
                                               brightness: 88)
                let deskLight = LightDevice(id: 2,
                                            name: "Desk Light",
                                            on: true,
                                            brightness: 88)
                let rgbDevice = RGBLight(id: 4,
                                         name: "RGB",
                                         on: true,
                                         brightness: 100,
                                         red: 100, green: 0, blue: 255)
                bedroomLocation.devices = [bedroomLight, deskLight, rgbDevice]
                
                let bathroomLocation = Location(id: 2, locationName: "Bathroom")
                let bathroomLight = LightDevice(id: 3,
                                                name: "Bathroom Light",
                                                on: false,
                                                brightness: 88)
                bathroomLocation.devices = [bathroomLight]
                
                HomeLightViewModel.shared.locations = [bedroomLocation, bathroomLocation]
            }
    }
}
