import SwiftUI

struct LocationView: View {
    
    private let locationIndex: Int
    @StateObject private var homeLightViewModel: HomeLightViewModel
    
    init(_ locationIndex: Int, _ homeLightViewModel: HomeLightViewModel) {
        self.locationIndex = locationIndex
        self._homeLightViewModel = StateObject(wrappedValue: homeLightViewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Lights")
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                        .padding(.top, 20)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<homeLightViewModel
                                .locations[locationIndex].lightDevices.count, id: \.self) { lightDeviceIndex in
                                    LightDeviceCardView(locationIndex, lightDeviceIndex, homeLightViewModel)
                                        .padding(.trailing, 10)
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    }
                    .padding(.top, 5)
                }
                .padding(.top, 30)
                VStack(alignment: .leading) {
                    Text("Sensors")
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                        .padding(.top, 20)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<homeLightViewModel
                                .locations[locationIndex].lightDevices.count, id: \.self) { lightDeviceIndex in
                                    LightDeviceCardView(locationIndex, lightDeviceIndex, homeLightViewModel)
                                        .padding(.trailing, 10)
                                    // TODO: Replace with SensorCardView
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    }
                    .padding(.top, 5)
                }
            }
            .navigationBarBackButtonHidden()
            .background {
                Background()
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        let location = Location(locationName: "Bedroom")
        let device1 = LightDevice(id: 11, name: "Bedroom Light", location: location, data: "", ipAddress: "", on: true)
        let device2 = LightDevice(id: 12, name: "Desk Light", location: location, data: "", ipAddress: "", on: false)
        let error = location.addDevice(device1)
        let error2 = location.addDevice(device2)
        let homeLightViewModel = HomeLightViewModel(locations: [location])
        LocationView(0, homeLightViewModel)
    }
}
