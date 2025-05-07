//
//  RegistrationViewVM.swift
//  MVC+FireBase TestApp
//
//  Created by Илья Паршин on 09.02.2025.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation

class RegistrationViewVM: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self]
            result, error in guard let userId = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool {
        guard validateNotEmpty(name),
                validateNotEmpty(email),
                validateNotEmpty(password) else {
            errorMessage = "All fields must be filled out."
            return false
        }
        
        guard validateEmail(email) else {
            errorMessage = "Invalid email format."
            return false
        }
        
        guard validatePassword(password) else {
            errorMessage = "Password must be at least 6 charecters, contain uppercase and lowercase letters, and one number or special symbol."
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
    
    private func validatePassword(_ password: String) -> Bool {
        let passwordRegEx = "^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])((?=.*\\d)|(?=.*[_!#$%&?])).*$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
    private func validateNotEmpty(_ string: String) -> Bool {
        !string.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
}
