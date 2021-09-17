//
//  User.swift
//  Fire
//
//  Created by Forrest Buhler on 8/20/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


class AppViewModel: ObservableObject {
    @Published var user = Users(id: "", username: "", name: "", email: "")
    @Published var users: [Users] = []
    @Published var posts: [Posts] = []
    @Published var signedIn = Bool()
    @Published var isLoading = false
    
    func loadPosts() {
        let db = Firestore.firestore()
        db.collection("posts").getDocuments(completion: { query, error in
            if self.posts.count != query?.count {
                for post in query!.documents {
                    
                    let storage = Storage.storage().reference().child("images")
                    storage.child(post.documentID).getData(maxSize: 20 * 1024 * 1024) { imageData, error in
                        if error == nil  {
                            let image = UIImage(data: imageData!)
                            self.posts.append(Posts(id: post.documentID, image: image!, caption: post.get("caption") as! String))

                        }
                    }
                }
            }
            
        })
    }
    
    
    
    func addPost(image: UIImage, caption: String) {
        let db = Firestore.firestore().collection("posts").addDocument(data: ["caption": caption])
        let postId = db.documentID
        let imageData = image.jpegData(compressionQuality: 1)
        let storage = Storage.storage().reference()
        storage.child("images").child(postId).putData(imageData!)
    }
    
    func signIn(email: String, password: String) {
        self.isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error == nil && result != nil {
                
                self.loadUser()
                
            } else {
                self.isLoading = false
            }
        }
    }
    
    func createAccount(email: String, password: String, username: String, name: String) {
        let db = Firestore.firestore()
        self.isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil && result != nil {
                self.changeUsername(username: username)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let data = ["name": name]
                    let uid = Auth.auth().currentUser!.uid
                    db.collection("users").document(uid).setData(data)
                    self.loadUser()
                }
            } else {
                self.isLoading = false
            }
        }
    }
    
    func loadUser() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let currentUser = Auth.auth().currentUser
            guard currentUser?.displayName != nil else { return }
            self.user.username = (currentUser?.displayName)!
            self.user.id = (currentUser?.uid)!
            self.signedIn = true
            self.isLoading = false
        }
    }
    
    func signOut() {
        do { try Auth.auth().signOut() } catch { print("Already logged out") }
        self.signedIn = false
        self.user = Users(id: "", username: "", name: "", email: "")
    }
    
    func changeUsername(username: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        changeRequest?.commitChanges(completion: { error in })
    }
    
    
}



