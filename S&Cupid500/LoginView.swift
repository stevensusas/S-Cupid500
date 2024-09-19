//
//  ContentView.swift
//  S&Cupid500
//
//  Created by Steven Su on 9/19/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            Image("Logo")
                .resizable()
                .frame(width: 200, height: 200)
            TextField(text: $username, prompt: Text("Username").foregroundColor(.gray)) {
                Text("Username")
            }
                .padding() // Adds padding inside the TextField
                .background(Color.gray.opacity(0.5)) // Light gray background
                .cornerRadius(8) // Rounded corners
                .foregroundColor(Color.white) // Makes the text inside white
                .padding(.horizontal, 16)
            SecureField(text: $password, prompt: Text("Password").foregroundColor(.gray)) {
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
                    print("Login")
                }) {
                    Text("Login")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button("Register") {
                }
            }
            Spacer()
        }
        .background(Color(UIColor(red: 26/255, green: 68/255, blue: 20/255, alpha: 1.0)))
    }
}

#Preview {
    LoginView()
}
