//
//  LogInViewVM.swift
//  MVC+FireBase TestApp
//
//  Created by Илья Паршин on 09.02.2025.
//

import FirebaseAuth
import Foundation

class LogInViewVM: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        //Try log in
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    private func validate() -> Bool {
        guard validateNotEmpty(email),
                validateNotEmpty(password) else {
            errorMessage = "All fields must be filled out."
            return false
        }
        
        guard validateEmail(email) else {
            errorMessage = "Invalid email format."
            return false
        }
        
        errorMessage = ""
        return true
    }
    
    private func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func validateNotEmpty(_ string: String) -> Bool {
        !string.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
}
