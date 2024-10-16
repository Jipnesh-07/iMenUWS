//
//  AdminTabBarController.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import SwiftUI

struct AdminTabBarController: View {
    var body: some View {
        TabView{
            AdminHomeView()
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
        }
    }
}

#Preview {
    AdminTabBarController()
}
