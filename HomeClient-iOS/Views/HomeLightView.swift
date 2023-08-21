import SwiftUI

struct HomeLightView: View {
    
    @StateObject private var homeLightViewModel: HomeLightViewModel
    
    init(_ homeViewModel: HomeLightViewModel) {
        _homeLightViewModel = StateObject(wrappedValue: homeViewModel)
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
                            if homeLightViewModel.locations[locationIndex].lightDevices.count == 0 {
                                Color.clear
                            } else {
                                VStack(alignment: .leading) {
                                    
                                    HStack {
                                        Button {
                                            // TODO: Go to DeviceLocationView
                                        } label: {
                                            HStack {
                                                Text(homeLightViewModel.locations[locationIndex].locationName)
                                                    .font(.title)
                                                    .foregroundColor(Color.primary)
                                                Image(systemName: "chevron.right")
                                            }
                                            .padding()
                                        }
                                    }
                                    
                                    HStack {
                                        Button {
                                            
                                        } label: {
                                            Text("Turn all on")
                                                .font(.headline)
                                                .padding()
                                                .foregroundColor(Color.primary)
                                                .background {
                                                    Rectangle()
                                                        .foregroundStyle(.ultraThinMaterial)
                                                        .cornerRadius(25)
                                                }
                                        }
                                        Button {
                                            
                                        } label: {
                                            Text("Turn all off")
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
                                    .padding(.bottom, 20)
                                    .padding(.leading, 20)
                                    
                                    
                                    LazyVGrid(columns: [.init(.adaptive(minimum: 200), spacing: -15)],  spacing: 18) {
                                        ForEach(0..<homeLightViewModel.locations[locationIndex].lightDevices.count, id: \.self) { deviceIndex in
                                            LightDeviceCardView(locationIndex, deviceIndex, homeLightViewModel)
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
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        let homeLightViewModel = HomeLightViewModel()
        HomeLightView(homeLightViewModel)
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
