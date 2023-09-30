import SwiftUI

struct RGBStripColorPicker: View {
    
    @ObservedObject var stripData: RGBStrip.StripData
    
    @State var staticColorSelection: Color = .clear
    
    var stripMode: RGBStrip.StripModeType {
        get {
            stripData.stripModeType
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    modeButton(modeType: .stripModeStatic)
                    modeButton(modeType: .stripModeBreathing)
                    modeButton(modeType: .stripModeRainbow)
                    modeButton(modeType: .stripModeSnake)
                }
                .padding(.horizontal, 10)
            }
            .padding(.top, 10)
            
            switch stripMode {
            case .stripModeStatic:
                ColorPicker("", selection: $staticColorSelection)
                    .frame(maxWidth: 0)
                
            default:
                Text("default")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Background()
        }
    }
    
    func modeButton(modeType: RGBStrip.StripModeType) -> some View {
        Button {
            stripData.stripModeType = modeType
        } label: {
            Text(modeType.rawValue)
                .font(.body.bold())
                .foregroundColor(.primary)
                .padding()
                .background {
                    Rectangle()
                        .foregroundStyle(.thinMaterial)
                        .cornerRadius(20)
                }
        }
    }
    
}

struct RGBStripColorPicker_Previews: PreviewProvider {
    
    @StateObject private static var stripData = RGBStrip.StripData(stripModeType: .stripModeStatic,
                                                                   speed: 0,
                                                                   length: 150)
    
    static var previews: some View {
        RGBStripColorPicker(stripData: stripData)
    }
}
