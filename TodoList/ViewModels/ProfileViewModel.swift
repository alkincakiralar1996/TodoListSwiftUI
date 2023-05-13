// Created by Alkın Çakıralar for TodoList in 1.05.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    init() { }
    
    @Published var user: User?
    
    @MainActor
    func fetchUser() async {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        let snapshot = try? await db.collection("users").document(userId).getDocument()
        
        guard let data = snapshot?.data() else {
            return
        }
        
        self.user = User(
            id: data["id"] as? String ?? "",
            name: data["name"] as? String ?? "",
            email: data["email"] as? String ?? "",
            joined: data["joined"] as? TimeInterval ?? 0
        )
    }
        
    func logOut() {
        try? Auth.auth().signOut()
    }
}
