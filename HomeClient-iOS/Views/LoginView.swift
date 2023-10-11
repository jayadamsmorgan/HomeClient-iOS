import SwiftUI
import Combine

struct LoginView: View {
    
    @State private var serverIP: String = "http://"
    @State private var serverPort: Int = 8080
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var saveLogin: Bool = false
    @State private var registerNewHome: Bool = false
    @State private var homeName: String = ""
    @State private var isHomeNameTextField: Bool = false
    @State private var loginButtonText: String = "Login"
    
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    if (isHomeNameTextField) {
                        TextField("Home name", text: $homeName)
                    }
                    HStack {
                        TextField("Server IP", text: $serverIP)
                        TextField("Server Port", value: $serverPort, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .frame(maxWidth: 57)
                    }
                    TextField("Username", text: $username)
                    SecureField("Password", text: $password)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 60)
                .textFieldStyle(.roundedBorder)
                
                Toggle("Save login information", isOn: $saveLogin)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 60)
                    .padding(.top, 10)
                
                Button {
                    if (!values_check()) {
                        return
                    }
                    if registerNewHome {
                        if (homeName == "") {
                            return
                        }
                        LoginViewModel.shared.registerNewHome(homeName: homeName,
                                                              serverIP: serverIP,
                                                              serverPort: serverPort,
                                                              username: username,
                                                              password: password,
                                                              saveLogin: saveLogin)
                        return
                    }
                    LoginViewModel.shared.login(serverIP: serverIP,
                                                serverPort: serverPort,
                                                username: username,
                                                password: password,
                                                saveLogin: saveLogin)
                } label: {
                    Text(loginButtonText)
                        .foregroundStyle(Color.primary)
                        .padding()
                        .background {
                            Rectangle()
                                .fill(Color.secondary)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 20)
                .padding(.trailing, 60)
                
                Toggle("Register new Smart Home", isOn: $registerNewHome)
                    .toggleStyle(.button)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 60)
                    .padding(.top, 10)
                    .onReceive(Just(registerNewHome)) { newValue in
                        withAnimation {
                            isHomeNameTextField = registerNewHome
                            loginButtonText = registerNewHome ? "Register" : "Login"
                        }
                    }
            }
            .frame(maxHeight: .infinity)
            .background {
                Background()
            }
        }
    }
    
    func values_check() -> Bool {
        if (serverIP == "" || serverIP == "http://") {
            //
            return false
        }
        if (username == "") {
            //
            return false
        }
        if (password == "") {
            //
            return false
        }
        return true
    }
}

struct LoginView_Previews: PreviewProvider {
    
    @State static var needsLogin = true
    
    static var previews: some View {
        LoginView()
    }
}
