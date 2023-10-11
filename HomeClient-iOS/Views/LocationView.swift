import SwiftUI

struct LocationView: View {
    
    private let locationIndex: Int
    @StateObject private var homeLightViewModel = HomeLightViewModel.shared
    
    init(_ locationIndex: Int) {
        self.locationIndex = locationIndex
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
                                .locations[locationIndex].devices.count, id: \.self) { deviceIndex in
                                    if type(of: homeLightViewModel.locations[locationIndex].devices[deviceIndex]) == LightDevice.self {
                                        LightDeviceCardView(lightDevice: homeLightViewModel.locations[locationIndex].devices[deviceIndex] as! LightDevice)
                                            .padding(.trailing, 10)
                                    }
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    }
                    .padding(.top, 5)
                }
                .padding(.top, 30)
                VStack(alignment: .leading) {
                    Text("RGB")
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                        .padding(.top, 20)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<homeLightViewModel
                                .locations[locationIndex].devices.count, id: \.self) { deviceIndex in
                                    if type(of: homeLightViewModel.locations[locationIndex].devices[deviceIndex]) == RGBLight.self {
                                        LightDeviceCardView(lightDevice: homeLightViewModel.locations[locationIndex].devices[deviceIndex] as! LightDevice)
                                            .padding(.trailing, 10)
                                    }
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    }
                    .padding(.top, 5)
                }
                VStack(alignment: .leading) {
                    Text("Sensors")
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                        .padding(.top, 20)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
//                            ForEach(0..<homeLightViewModel
//                                .locations[locationIndex].devices.count, id: \.self) { deviceIndex in
//                                    if type(of: homeLightViewModel.locations[locationIndex].devices[deviceIndex]) == Sensor.self {
//                                        LightDeviceCardView(lightDevice: homeLightViewModel.locations[locationIndex].devices[deviceIndex] as! LightDevice)
//                                            .padding(.trailing, 10)
//                                    }
//                            }
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
        let location = Location(id: 1, locationName: "Bedroom")
        let device1 = LightDevice(id: 11, name: "Bedroom Light", on: true, brightness: 100)
        let device2 = LightDevice(id: 12, name: "Desk Light", on: false, brightness: 100)
        let device3 = RGBLight(id: 13, name: "RGB", on: false, brightness: 100, red: 255, green: 0, blue: 255)
        let _ = (location.devices = [device1, device2, device3])
        let _ = (HomeLightViewModel.shared.locations = [location])
        LocationView(0)
    }
}
