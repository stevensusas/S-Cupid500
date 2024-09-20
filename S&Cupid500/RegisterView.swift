//
//  RegisterView.swift
//  S&Cupid500
//
//  Created by Steven Su on 9/19/24.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                Text("Register")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                Spacer().frame(height: 50)
                TextField(text: $authModel.email, prompt: Text("Email").foregroundColor(.gray)) {
                    Text("Email")
                }
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(8)
                                .foregroundColor(Color.white) // Makes the text inside white
                .padding(.horizontal, 16)
                SecureField(text: $authModel.password, prompt: Text("Password").foregroundColor(.gray)) {
                    Text("Password")
                }
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(8)
                .foregroundColor(Color.white)
                .padding(.horizontal, 16)
                Spacer().frame(height: 40)
                Button(action: {
                    authModel.register()
                }) {
                    Text("Register")
                        .padding()
                        .fontWeight(.bold)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10.0)
                }
                if !authModel.errorMessage.isEmpty {
                    Text("\(authModel.errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }
                Spacer()
            }
            .background(Color(UIColor(red: 26/255, green: 68/255, blue: 20/255, alpha: 1.0)))
            
        }
    }
        }

#Preview {
    RegisterView()
}
