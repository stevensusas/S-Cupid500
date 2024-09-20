//
//  ContentView.swift
//  S&Cupid500
//
//  Created by Steven Su on 9/19/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authModel = AuthModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                TextField(text: $authModel.email, prompt: Text("Username").foregroundColor(.gray)) {
                    Text("Username")
                }
                .padding() // Adds padding inside the TextField
                .background(Color.gray.opacity(0.5)) // Light gray background
                .cornerRadius(8) // Rounded corners
                .foregroundColor(Color.white) // Makes the text inside white
                .padding(.horizontal, 16)
                SecureField(text: $authModel.password, prompt: Text("Password").foregroundColor(.gray)) {
                    Text("Password")
                }
                .padding() // Adds padding inside the TextField
                .background(Color.gray.opacity(0.5)) // Light gray background
                .cornerRadius(8) // Rounded corners
                .foregroundColor(Color.white) // Makes the text inside white
                .padding(.horizontal, 16)
                Spacer().frame(height: 25)
                HStack {
                    Button(action: {
                        authModel.login()
                    }) {
                        Text("Login")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .foregroundColor(.blue)
                    }
                }
                if !authModel.errorMessage.isEmpty {
                    Text(authModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                Spacer()
                NavigationLink(
                                    destination: HomeView(),
                                    isActive: $authModel.isLoggedIn,
                                    label: {
                                        EmptyView() // Hidden link triggered by state
                                    }
                                )
            }
            .background(Color(UIColor(red: 26/255, green: 68/255, blue: 20/255, alpha: 1.0)))
        }
    }
}
#Preview {
    LoginView()
}
