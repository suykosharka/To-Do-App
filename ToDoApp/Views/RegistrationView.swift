//
//  RegistrationView.swift
//  MVC+FireBase TestApp
//
//  Created by Илья Паршин on 09.02.2025.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject var viewModel = RegistrationViewVM()
    
    var body: some View {
        VStack {
            //Header
            HeaderView(title: "Regiser", subtitle: "Let's begin", background: .orange)
            
            Form {
                
                if !viewModel.errorMessage.isEmpty{
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color.red)
                }
                
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                CustomButtonView(title: "Create Account", background: .green, action: {
                    viewModel.register()
                })
            }
            
            Spacer()
        }
    }
}

#Preview {
    RegistrationView()
}

