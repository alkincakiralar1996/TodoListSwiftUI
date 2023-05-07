// Created by Alkın Çakıralar for TodoList in 1.05.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/

import FirebaseAuth
import Foundation

@MainActor
class MainViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?

    init() {
        handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            self.currentUserId = user?.uid ?? ""
        }
    }

    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
