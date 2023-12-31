import SwiftUI
import Combine

struct RGBLightCardView: View {
    
    @ObservedObject var rgbLightDevice: RGBLight
    
    @State var selectionColor: Color = .clear
    @State var lastSelectionColor: Color = .clear
    
    private var backgroundColor: Color {
        if rgbLightDevice.on {
            // Color accepts sRGB range [0.0-1.0] (Double)
            return Color(.sRGB,
                         red: Double(rgbLightDevice.getRed) / 255.0,
                         green: Double(rgbLightDevice.getGreen) / 255.0,
                         blue: Double(rgbLightDevice.getBlue) / 255.0)
        } else {
            return Color.clear
        }
    }
    
    private var brightness: Double {
        (Double(rgbLightDevice.getBrightness) / 2 + 50) / 100.0 // Making brightness range to be [0.5-1.0]
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Menu {
                menuItems
            } label: {
                ZStack(alignment: .topLeading){
                    Rectangle()
                        .fill(backgroundColor)
                        .opacity(brightness)
                        .frame(width: 110, height: 110)
                        .cornerRadius(40)
                        .blur(radius: 30)
                        .padding(.top, 30)
                        .padding(.leading, 30)
                    Rectangle()
                        .foregroundStyle(.ultraThinMaterial)
                        .frame(width: 170, height: 170)
                        .cornerRadius(25)
                    Text(rgbLightDevice.name)
                        .foregroundColor(.primary)
                        .font(.system(size: 22).bold())
                        .multilineTextAlignment(.leading)
                        .frame(minWidth: 95, maxWidth: 130)
                        .padding(.leading, 15)
                        .padding(.top, 15)
                    if rgbLightDevice.getBrightness < 100 && rgbLightDevice.on {
                        Text("\(rgbLightDevice.getBrightness)%")
                            .foregroundColor(.primary)
                            .font(.system(size: 22).bold())
                            .padding(.leading, 110)
                            .padding(.top, 130)
                    }
                }
            } primaryAction: {
                withAnimation {
                    rgbLightDevice.toggle()
                }
                HomeLightViewModel.shared.sendDeviceState(device: rgbLightDevice)
            }
            if (rgbLightDevice.isOn) {
                ColorPicker(selection: $selectionColor) { }
                .onReceive(Just(selectionColor), perform: { newValue in
                    if newValue != lastSelectionColor {
                        if let components = newValue.cgColor?.components {
                            withAnimation {
                                rgbLightDevice.setRed(Int(components[0] * 255))
                                rgbLightDevice.setGreen(Int(components[1] * 255))
                                rgbLightDevice.setBlue(Int(components[2] * 255))
                            }
                        }
                        lastSelectionColor = newValue
                        HomeLightViewModel.shared.sendDeviceState(device: rgbLightDevice)
                    }
                })
                .frame(width: 0)
                .padding(.bottom, 20)
                .padding(.leading, 30)
            }
            
        }
    }
    
    var menuItems: some View {
        Group {
            if rgbLightDevice.isOn {
                Button("Turn off", action: {
                    withAnimation {
                        rgbLightDevice.toggle()
                    }
                    HomeLightViewModel.shared.sendDeviceState(device: rgbLightDevice)
                })
            } else {
                Button("Turn on", action: {
                    withAnimation {
                        rgbLightDevice.toggle()
                    }
                    HomeLightViewModel.shared.sendDeviceState(device: rgbLightDevice)
                })
            }
            Button("Set full brightness", action: {
                withAnimation {
                    rgbLightDevice.setBrightness(100)
                }
                HomeLightViewModel.shared.sendDeviceState(device: rgbLightDevice)
            })
            Button("Set brightness 60%", action: {
                withAnimation {
                    rgbLightDevice.setBrightness(60)
                }
                HomeLightViewModel.shared.sendDeviceState(device: rgbLightDevice)
            })
            Button("Set brightness 30%", action: {
                withAnimation {
                    rgbLightDevice.setBrightness(30)
                }
                HomeLightViewModel.shared.sendDeviceState(device: rgbLightDevice)
            })
        }
    }
}

struct RGBLightCardView_Previews: PreviewProvider {
    
    @StateObject static private var rgbLightDevice = RGBLight(id: "1",
                                                              name: "Bedroom RGB Strip",
                                                              on: true,
                                                              brightness: 100,
                                                              red: 255,
                                                              green: 0,
                                                              blue: 0)
    private static let location = Location(locationName: "Bedroom")
    
    static var previews: some View {
        RGBLightCardView(rgbLightDevice: rgbLightDevice)
    }
}
