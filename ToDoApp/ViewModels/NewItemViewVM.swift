//
//  NewItemViewVM.swift
//  MVC+FireBase TestApp
//
//  Created by Илья Паршин on 09.02.2025.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class NewItemViewVM: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    
    init(){}
    
    func save() {
        guard canSave else{
            return
        }
        
        //Get current userId
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        //Create model
        let newId = UUID().uuidString
        let newItem = ToDoListItem(id: newId, title: title, dueDAte: dueDate.timeIntervalSince1970, createDate: Date().timeIntervalSince1970, isDone: false)
        
        //Save model
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary())
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
}
