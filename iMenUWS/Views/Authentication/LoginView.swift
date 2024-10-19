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
                // Username field
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textInputAutocapitalization(.never)
                
                // Password field
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textInputAutocapitalization(.never)
                
                // Login Button
                Button("Login") {
                    login()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                // Show error message if login fails
                if loginFailed {
                    Text("Invalid credentials")
                        .foregroundColor(.red)
                }
                
                // Navigation to Admin or User views based on login
                if isLoggedIn, let userType = userType {
                    NavigationLink("", destination: destinationView(for: userType), isActive: $isLoggedIn)
                        .hidden()
                }
            }
            .padding()
            .navigationTitle("Login")
            .onAppear {
                resetState() // Reset the state when the view reappears
            }
        }
    }
    
    func login() {
        // Check for valid credentials
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
    
    // Function to handle destination view based on userType
    @ViewBuilder
    func destinationView(for userType: UserType) -> some View {
        switch userType {
        case .admin:
            AdminTabBarController()
        case .user:
            UserTabBarControllerr()
        }
    }
    
    // Function to reset the state when the view appears again
    func resetState() {
        // Reset loginFailed and clear the input fields
        loginFailed = false
        username = ""
        password = ""
        isLoggedIn = false
    }
}

enum UserType {
    case admin
    case user
}

#Preview {
    LoginView()
}
