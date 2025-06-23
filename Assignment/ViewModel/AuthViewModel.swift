//
//  AuthViewModel.swift
//  Assignment
//
//  Created by Bhagyadhar Sahoo on 22/06/25.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import CoreData
import UIKit
import FirebaseCore

final class AuthViewModel {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func signInWithGoogle(presentingVC: UIViewController, completion: @escaping (Bool) -> Void) {

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { user, error in
            
            if let error = error {
                print("Google Sign-In error: \(error)")
                completion(false)
                return
            }
            
            if let user {
                self.saveUserToCoreData(firebaseUser: user.user)
                completion(true)
            }
        }
    }
    
    func logOut() {
        GIDSignIn.sharedInstance.signOut()
        deleteUserFromCoreData()
    }

    private func saveUserToCoreData(firebaseUser: GIDGoogleUser) {
        let userEntity = AppUser(context: context)
        userEntity.userId = firebaseUser.userID
        userEntity.name = firebaseUser.profile?.name
        userEntity.email = firebaseUser.profile?.email

        do {
            try context.save()
            print("✅ User saved in Core Data")
        } catch {
            print("❌ Error saving user: \(error.localizedDescription)")
        }
    }
    
    func deleteUserFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = AppUser.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
            print("🗑️ User data deleted from Core Data")
        } catch {
            print("❌ Failed to delete user: \(error.localizedDescription)")
        }
    }
    
    func isUserSavedInCoreData() -> Bool {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        if let result = try? context.fetch(request), result.count > 0 {
            return true
        }
        return false
    }
}
