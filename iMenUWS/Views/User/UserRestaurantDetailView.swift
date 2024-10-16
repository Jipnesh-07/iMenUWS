//
//  UserRestaurantDetailView.swift
//  iMenUWS
//
//  Created by student on 16/10/24.
//

import SwiftUI

struct UserRestaurantDetailView: View {
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: UserFoodDetailsView()){
                    Text("Hellow")
                }
            }
        }
    }
}

#Preview {
    UserRestaurantDetailView()
}
