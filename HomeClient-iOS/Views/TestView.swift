import SwiftUI

struct TestView: View {
    
    @StateObject private var lightDevice: LightDevice

        init() {
            let location = Location(locationName: "Bedroom")
            let lightDevice = LightDevice(
                id: 11,
                name: "Bedroom Light",
                location: location,
                data: "",
                ipAddress: "",
                on: true
            )
            self._lightDevice = StateObject(wrappedValue: lightDevice)
        }

        var body: some View {
            VStack {
                LightDeviceCardView(lightDevice: lightDevice)
                LightDeviceCardView(lightDevice: lightDevice)
            }
        }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
