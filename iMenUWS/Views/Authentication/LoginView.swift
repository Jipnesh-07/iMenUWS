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
    @AppStorage("isLoggedIn") private var isLoggedIn = false // Persist login state
    @State private var userType: UserType?

    var body: some View {
        if isLoggedIn, let userType = userType {
            NavigationView {
                destinationView(for: userType)
            }
        } else {
            loginForm
        }
    }

    var loginForm: some View {
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
        }
        .padding()
        .navigationTitle("Login")
        .onAppear {
            resetState() // Reset the state when the view reappears
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

    @ViewBuilder
    func destinationView(for userType: UserType) -> some View {
        switch userType {
        case .admin:
            AdminTabBarController()
        case .user:
            UserTabBarControllerr()
        }
    }

    func resetState() {
        loginFailed = false
        username = ""
        password = ""
    }
}

enum UserType {
    case admin
    case user
}

#Preview {
    LoginView()
}
