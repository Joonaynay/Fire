//
//  HomeView.swift
//  Fire
//
//  Created by Forrest Buhler on 8/20/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    Button("Load") { viewModel.loadPosts() }
                    ScrollView {
                        ForEach(viewModel.posts.reversed()) { post in
                            Image(uiImage: post.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.width)
                                .clipped()
                            Text(post.caption)
                        }
                    }
                    .navigationTitle("Home")
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
