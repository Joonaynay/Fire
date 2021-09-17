//
//  MainView.swift
//  Fire
//
//  Created by Forrest Buhler on 8/20/21.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        if viewModel.signedIn {
            TabView {
                HomeView().tabItem { Image(systemName: "house") }
                PostView().tabItem { Image(systemName: "plus.square") }
                ProfileView().tabItem { Image(systemName: "person") }
            }
        } else {
            LoginView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
