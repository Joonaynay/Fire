//
//  ContentView.swift
//  Fire
//
//  Created by Forrest Buhler on 8/20/21.
//

import SwiftUI

struct LoginView: View {
    
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var email = "test@email.com"
    @State var password = "123456"
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                    Button("Sign In") { viewModel.signIn(email: email, password: password) }
                    NavigationLink(destination: CreateAccountView(), label: { Text("Create Account").foregroundColor(.blue) })
                }
                if viewModel.isLoading {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.black).opacity(0.2)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 64, height: 64)
                }
            }
        }
    }
}

struct CreateAccountView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var username = "jonbuhler14"
    @State var firstName = "Jonathon"
    @State var lastName = "Buhler"
    @State var email = "test@email.com"
    @State var password = "123456"
    @State var confirmPassword = "123456"
    
    var body: some View {
        ZStack {
            Form {
                TextField("Username", text: $username)
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                SecureField("Confirm Password", text: $confirmPassword)
                Button("Create Account") { viewModel.createAccount(email: email, password: password, username: username, name: "\(firstName) \(lastName)") }
            }
            if viewModel.isLoading {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(.black).opacity(0.2)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: 64, height: 64)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
