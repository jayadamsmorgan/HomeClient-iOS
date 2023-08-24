import SwiftUI

struct LightDeviceCardView: View {
    
    @ObservedObject var lightDevice: LightDevice
    
    private var backgroundColor: Color {
        lightDevice.isOn ? .yellow : .clear
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
            Text(lightDevice.name)
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
            withAnimation {
                lightDevice.toggle()
            }
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
    
    private static let location = Location(locationName: "Bedroom")
    @StateObject private static var lightDevice: LightDevice = LightDevice(
        id: 11,
        name: "Bedroom Light",
        location: location,
        data: "",
        ipAddress: "",
        on: true
    )
    
    static var previews: some View {
        LightDeviceCardView(lightDevice: lightDevice)
    }
}
