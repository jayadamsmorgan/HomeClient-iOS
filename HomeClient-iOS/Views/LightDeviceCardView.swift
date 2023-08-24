import SwiftUI

struct LightDeviceCardView: View {
    
    @ObservedObject var lightDevice: LightDevice
    
    private var backgroundColor: Color {
        lightDevice.isOn ? .yellow : .clear
    }
    
    private var brightness: Double {
        (Double(lightDevice.getBrightness) / 100.0)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(backgroundColor)
                .opacity(brightness)
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
            if lightDevice.getBrightness < 100 && lightDevice.isOn {
                Text("\(lightDevice.getBrightness)%")
                    .foregroundColor(.primary)
                    .font(.system(size: 22).bold())
                    .padding(.leading, 110)
                    .padding(.top, 130)
            }
        }
        .contextMenu {
            lightCardContextMenuItems
        }
        .onAppear {
            withAnimation {
                lightDevice.setBrightness(90)
            }
        }
        .onTapGesture {
            withAnimation {
                lightDevice.toggle()
            }
        }
    }
    
    var lightCardContextMenuItems: some View {
        Group {
            Button("Action 1", action: { lightDevice.setBrightness(100) })
            Button("Action 2", action: { lightDevice.setBrightness(60) })
            Button("Action 3", action: { lightDevice.setBrightness(30) })
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
