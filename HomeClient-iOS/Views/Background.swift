import SwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.thinMaterial)
        }
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
