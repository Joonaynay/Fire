//
//  PostView.swift
//  Fire
//
//  Created by Forrest Buhler on 8/23/21.
//

import SwiftUI
import AVKit

struct PostView: View {
    
    @State private var caption: String = ""
    @State private var imagePicker: Bool = false
    @State var image: UIImage? = nil
    @EnvironmentObject var viewModel: AppViewModel
    @State var selection: String? = ""
    @State var url = URL(string: "")
    
    var body: some View {
        
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    NavigationLink(destination: view(), tag: "view", selection: $selection, label: {})
                    VStack(alignment: .leading) {
                        Button("Select Image...") { imagePicker = true }
                            .padding()
                        TextField("Caption", text: $caption)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Button("Post") { viewModel.addPost(image: image!, caption: caption) }
                            .padding()
                        if image != nil {
                            Image(uiImage: image!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.width)
                                .clipped()
                        }
                        if url != URL(string: "") {
                            VideoPlayer(player: AVPlayer(url: url!))
                        }
                    }
                }
                .sheet(isPresented: $imagePicker, content: { ImagePickerView(image: $image, tag: $selection, url: $url) })
                .navigationTitle("New Post")
            }
        }
        
    }
}

struct view: View {
    var body: some View {
        Text("")
    }
}
