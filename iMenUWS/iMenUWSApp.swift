//
//  iMenUWSApp.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import SwiftUI

@main
struct iMenUWSApp: App {
    @StateObject private var orderManager = OrderManager() // Initialize OrderManager
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(orderManager) // Provide it to the environment
            
        }
    }
}
