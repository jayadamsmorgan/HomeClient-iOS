import SwiftUI

struct LightDeviceCardView: View {
    
    @State var device: LightDevice
    
    @State private var backgroundColor: Color
    
    init(_ device: LightDevice) {
        self.device = device
        self.backgroundColor = device.on ? Color.yellow : Color.clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .frame(width: 170, height: 170)
                .cornerRadius(25)
            Rectangle()
                .fill(backgroundColor)
                .frame(width: 110, height: 110)
                .cornerRadius(40)
                .offset(x: 30, y: 20)
                .opacity(0.7)
                .blur(radius: 30)
            Text(device.name)
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
            device.on.toggle()
            buttonVisualToggle()
        }
    }
    
    func buttonVisualToggle() {
        withAnimation {
            self.backgroundColor = device.on ? Color.yellow : Color.clear
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
        LightDeviceCardView(LightDevice(id: 11, name: "Bedroom Light", locationString: "Bedroom", ipAddress: "192.168.1.31", on: true))
    }
}
