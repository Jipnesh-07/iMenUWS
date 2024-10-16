//
//  LoginView.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.


import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var loginFailed = false
    @State private var isLoggedIn = false
    @State private var userType: UserType?
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textInputAutocapitalization(.never)
                
                Button("Login") {
                    login()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                if loginFailed {
                    Text("Invalid credentials")
                        .foregroundColor(.red)
                }
                
                // Navigation to Admin or User views based on login
                if userType == .admin {
                    NavigationLink("", destination: AdminTabBarController(), isActive: Binding.constant(true))
                } else if userType == .user {
                    NavigationLink("", destination: UserTabBarControllerr(), isActive: Binding.constant(true))
                }
            }
            .padding()
            .navigationTitle("Login")
        }
    }
    
    func login() {
        if username == "admin" && password == "admin123" {
            userType = .admin
            isLoggedIn = true
        } else if username == "user" && password == "user123" {
            userType = .user
            isLoggedIn = true
        } else {
            loginFailed = true
        }
    }
}

enum UserType {
    case admin
    case user
}

#Preview {
    LoginView()
}
