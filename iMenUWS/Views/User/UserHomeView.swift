//
//  UserHomeView.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import SwiftUI

struct UserHomeView: View {
    @State private var searchText: String = ""
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false){
                
                VStack(alignment: .leading,spacing: -10){
                    
                    Text("Top Picks")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.horizontal,.bottom])
                    // Restaurant rows displayed in a VStack
                    
                    
                    
                    
                }
                .navigationTitle("Home")
                .searchable(text: $searchText)
                
            }
        }
    }
}

#Preview {
    UserHomeView()
}
