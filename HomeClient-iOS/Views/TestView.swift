import SwiftUI

struct TestView: View {
    
    @StateObject private var lightDevice: LightDevice

        init() {
            let location = Location(id: 1, locationName: "Bedroom")
            let lightDevice = LightDevice(
                id: 11,
                name: "Bedroom Light",
                location: location,
                data: "",
                ipAddress: "",
                on: true,
                brightness: 100
            )
            self._lightDevice = StateObject(wrappedValue: lightDevice)
        }

        var body: some View {
            VStack {
                Menu {
                    Button(action: {}) {
                        Label("Add to Reading List", systemImage: "eyeglasses")
                    }
                    Button(action: {}) {
                        Label("Add Bookmarks for All Tabs", systemImage: "book")
                    }
                    Button(action: {}) {
                        Label("Show All Bookmarks", systemImage: "books.vertical")
                    }
                } label: {
                    
                } primaryAction: {
                    
                }
                LightDeviceCardView(lightDevice: lightDevice)
            }
        }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
