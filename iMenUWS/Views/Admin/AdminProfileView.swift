//
//  AdminProfileView.swift
//  iMenUWS
//
//  Created by STUDENT on 19/10/24.
//
import SwiftUI

struct AdminProfileView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        VStack {
            Text("Admin Profile")

            Button("Logout") {
                isLoggedIn = false // Logout and return to LoginView
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    AdminProfileView()
}
