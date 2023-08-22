import SwiftUI

struct LightDeviceCardView: View {
    
    @StateObject private var homeLightViewModel: HomeLightViewModel
    
    private let locationIndex: Int
    private let deviceIndex: Int
    
    @State private var backgroundColor: Color
    
    init(_ locationIndex: Int,
         _ deviceIndex: Int,
         _ homeLightViewModel: HomeLightViewModel) {
        
        self._homeLightViewModel = StateObject(wrappedValue: homeLightViewModel)
        self.locationIndex = locationIndex
        self.deviceIndex = deviceIndex
        self.backgroundColor = homeLightViewModel
            .locations[locationIndex]
            .lightDevices[deviceIndex]
            .on ? Color.yellow : Color.clear
        
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(backgroundColor)
                .frame(width: 110, height: 110)
                .cornerRadius(40)
                .offset(x: 30, y: 30)
                .blur(radius: 30)
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .frame(width: 170, height: 170)
                .cornerRadius(25)
            Text(homeLightViewModel
                .locations[locationIndex]
                .lightDevices[deviceIndex]
                .name)
                .foregroundColor(.primary)
                .font(.system(size: 22).bold())
                .multilineTextAlignment(.leading)
                .frame(minWidth: 95, maxWidth: 130)
                .padding(.leading, 15)
                .padding(.top, 15)
        }
        .contextMenu {
            lightCardContextMenuItems
        }
        .onTapGesture {
            homeLightViewModel
                .toggleLightDevice(locationIndex, deviceIndex)
            buttonVisualToggle()
        }
    }
    
    func buttonVisualToggle() {
        withAnimation {
            self.backgroundColor = homeLightViewModel
                .locations[locationIndex]
                .lightDevices[deviceIndex]
                .on ? Color.yellow : Color.clear
        }
    }
    
    var lightCardContextMenuItems: some View {
        Group {
            Button("Action 1", action: { })
            Button("Action 2", action: { })
            Button("Action 3", action: { })
        }
    }
}

struct LightDeviceCardView_Previews: PreviewProvider {
    static var previews: some View {
        let location = Location(locationName: "Bedroom")
        let device = LightDevice(id: 11, name: "Bedroom Light", location: location, data: "", ipAddress: "", on: true)
        let error = location.addDevice(device)
        let homeLightViewModel = HomeLightViewModel(locations: [location])
        LightDeviceCardView(0, 0, homeLightViewModel)
    }
}
