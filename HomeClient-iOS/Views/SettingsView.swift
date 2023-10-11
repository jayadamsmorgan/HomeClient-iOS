import SwiftUI

struct SettingsView: View {
    
    @StateObject private var settingsViewModel = SettingsViewModel.shared
    
    @State var serverIPAdress = "http://"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("Server IP Address", text: $serverIPAdress)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)
                Button {
                    settingsViewModel.saveServerIPAdress(ip: serverIPAdress)
                } label: {
                    Text("Save")
                        .padding()
                        .background {
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(10)
                        }
                }
            }
            .navigationTitle("Settings")
            .background {
                Background()
            }
        }
        .onAppear {
            serverIPAdress = settingsViewModel.getSavedServerIPAddress() ?? serverIPAdress
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
