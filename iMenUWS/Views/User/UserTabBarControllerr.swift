//
//  UserTabBarControllerr.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import SwiftUI

struct UserTabBarControllerr: View {
    var body: some View {
        TabView{
            UserHomeView()
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
        }
    }
}

#Preview {
    UserTabBarControllerr()
}
