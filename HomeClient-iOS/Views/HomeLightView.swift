import SwiftUI

struct HomeLightView: View {
    
    @StateObject private var homeLightViewModel: HomeLightViewModel
    
    @State var deviceId: Int = 16
    
    init(_ homeViewModel: HomeLightViewModel) {
        _homeLightViewModel = StateObject(wrappedValue: homeViewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if (homeLightViewModel.locations.count == 0) {
                    Text("No devices in your home yet")
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(homeLightViewModel.locations, id: \.self) { location in
                                VStack(alignment: .leading) {
                                    
                                    HStack {
                                        Button {
                                            // TODO: Go to DeviceLocationView
                                        } label: {
                                            HStack {
                                                Text(location.locationName)
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
//                                        ForEach(location.devices, id: \.self) { device in
//                                            if type(of: device) == LightDevice.Type.self {
//                                                LightDeviceCardView(device)
//                                            }
//                                        }
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
    }
}
