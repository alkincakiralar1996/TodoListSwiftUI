// Created by Alkın Çakıralar for TodoList in 1.05.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HeaderView(
                    title: "To Do List",
                    subtitle: "Get things done",
                    angle: 15,
                    background: .pink
                )

                // login form
                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())

                    TLButton(
                        title: "Log In",
                        background: .blue) {
                        }
                        .padding()
                }
                .offset(y: -50)

                VStack {
                    Text("New around here?")
                    NavigationLink(
                        "Create An Account",
                        destination: RegisterView()
                    )
                }
                .padding(.bottom, 50)

                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
