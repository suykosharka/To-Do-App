//
//  ToDoListItemViewVM.swift
//  MVC+FireBase TestApp
//
//  Created by Илья Паршин on 09.02.2025.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class ToDoListItemViewVM: ObservableObject {
    init(){}
    
    func toggleIsDone(item: ToDoListItem){
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
