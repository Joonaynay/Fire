//
//  ProfileView.swift
//  Fire
//
//  Created by Forrest Buhler on 8/23/21.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Profile()
            Button("Sign Out") {
                viewModel.signOut()
            }
            Spacer()
        }
    }
}


struct Profile: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .padding()
                .scaledToFit()
                .frame(width: 128, height: 128)
            Text(viewModel.user.username)
                .padding(.horizontal)
                .padding(.bottom)
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
        }
    }
}
