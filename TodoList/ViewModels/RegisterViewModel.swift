// Created by Alkın Çakıralar for TodoList in 1.05.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    
    init() {}
    
    func register() async {
        guard validate() else {
            return
        }
        
        let result = try? await Auth.auth().createUser(withEmail: email, password: password)
        
        guard let userId = result?.user.uid else {
            return
        }
        
        await insertUserRecord(userId: userId)
    }
    
    private func insertUserRecord(userId id: String) async {
        let newUser = User(
            id: id,
            name: name,
            email: email,
            joined: Date().timeIntervalSince1970
        )
        
        let db = Firestore.firestore()
        
        try? await db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard email.isValidEmail else {
            return false
        }
        
        guard password.count >= 6 else {
            return false
        }
        
        return true
    }
}
