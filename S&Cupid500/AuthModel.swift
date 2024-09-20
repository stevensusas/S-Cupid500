//
//  AuthModel.swift
//  S&Cupid500
//
//  Created by Steven Su on 9/19/24.
//

import Foundation
import FirebaseAuth

class AuthModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isLoggedIn = false
    @Published var registered = false
    @Published var useruid = ""
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) {
            authResult, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .networkError:
                    self.errorMessage = "Network error: Please check your internet connection."
                case .userNotFound:
                    self.errorMessage = "User not found: Please check your email."
                case .wrongPassword:
                    self.errorMessage = "Invalid password: Please try again."
                case .emailAlreadyInUse:
                    self.errorMessage = "This email is already in use. Please use a different email."
                case .weakPassword:
                    self.errorMessage = "Your password is too weak. Please use a stronger password."
                default:
                    self.errorMessage = "An error occurred: \(error.localizedDescription)"
                }
            } else {
                self.registered = true
                print("success")
            }
        }
    }
    
func login() {
    Auth.auth().signIn(withEmail: email, password: password) {
        authResult, error in
        if let error = error {
            self.errorMessage = error.localizedDescription
        } else {
            self.isLoggedIn = true
            guard let user = authResult?.user else {return}
            self.useruid = user.uid
        }
    }
    }
}
