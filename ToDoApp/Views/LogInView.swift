//
//  LogInView.swift
//  MVC+FireBase TestApp
//
//  Created by Илья Паршин on 09.02.2025.
//

import SwiftUI

struct LogInView: View {
    
    @StateObject var viewModel = LogInViewVM()
    
    var body: some View {
        NavigationView {
            VStack {
                
                //Header
                HeaderView(title: "To Do List", subtitle: "Stay on track", background: .pink)
                
                //Log In Form
                Form {
                    
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Email Adress", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    CustomButtonView(title: "Log In", background: .blue) {
                        viewModel.login()
                    }
                }
                
                //Create Account
                VStack {
                    Text("New around here?")
                    NavigationLink("Create an Account", destination: RegistrationView())
                }
                .padding(.bottom, 50)
                Spacer()
            }
        }
    }
}

#Preview {
    LogInView()
}
