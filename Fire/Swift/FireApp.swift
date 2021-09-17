//
//  FireApp.swift
//  Fire
//
//  Created by Forrest Buhler on 8/20/21.
//

import SwiftUI
import Firebase

@main
struct FireApp: App {
    
    @StateObject var viewModel = AppViewModel()
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}
