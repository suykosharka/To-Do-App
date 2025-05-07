//
//  ContentViewVM.swift
//  MVC+FireBase TestApp
//
//  Created by Илья Паршин on 09.02.2025.
//

import FirebaseAuth
import Foundation


class ContentViewVM: ObservableObject {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init(){
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
        
    }
}
