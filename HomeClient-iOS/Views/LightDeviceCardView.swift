import SwiftUI

struct LightDeviceCardView: View {
    
    @ObservedObject var lightDevice: LightDevice
    
    private var backgroundColor: Color {
        lightDevice.isOn ? .yellow : .clear
    }
    
    private var brightness: Double {
        (Double(lightDevice.getBrightness) / 2 + 50) / 100.0 // Making "visible brightness" range to be [0.5-1.0]
    }
    
    var body: some View {
        
        Menu {
            menuItems
        } label: {
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
        } primaryAction: {
            withAnimation {
                lightDevice.toggle()
            }
        }
    }
    
    var menuItems: some View {
        Group {
            if lightDevice.isOn {
                Button("Turn off", action: {
                    withAnimation {
                        lightDevice.toggle()
                    }
                    let request = NetworkManager.shared.post(resource: "/devices/\(lightDevice.id)", object: DeviceWrapper(deviceType: "RGBLightDevice", device: lightDevice))
                    request?
                        .onSuccess { callback in
                            print("OK")
                        }
                        .onFailure { callback in
                            print(callback)
                        }
                })
            } else {
                Button("Turn on",  action: {
                    withAnimation {
                        lightDevice.toggle()
                    }
                    let request = NetworkManager.shared.post(resource: "/devices/\(lightDevice.id)", object: DeviceWrapper(deviceType: "RGBLightDevice", device: lightDevice))
                    request?
                        .onSuccess { callback in
                            print("OK")
                        }
                        .onFailure { callback in
                            print(callback)
                        }
                })
            }
            Button("Set full brightness", action: { withAnimation { lightDevice.setBrightness(100) } })
            Button("Set brightness 60%", action: { withAnimation { lightDevice.setBrightness(60) } })
            Button("Set brightness 30%", action: { withAnimation { lightDevice.setBrightness(30) } })
        }
    }
}

struct LightDeviceCardView_Previews: PreviewProvider {
    
    private static let location = Location(id: 1, locationName: "Bedroom")
    @StateObject private static var lightDevice: RGBLight = RGBLight(
        id: 11,
        name: "Bedroom Light",
        on: true,
        brightness: 100,
        red: 255,
        green: 0,
        blue: 255
    )
    
    static var previews: some View {
        LightDeviceCardView(lightDevice: lightDevice)
    }
}
