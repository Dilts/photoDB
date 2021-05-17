//
//  UserService.swift
//  photoDB
//
//  Created by Brian Dilts on 5/17/21.
//

import Foundation
import FirebaseFirestore

class UserService {
    
    static func retrieveProfile(userId:String, completion: @escaping (PhotoUser?) -> Void ) {
        
        // Get a firestore reference
        let db = Firestore.firestore()
        
        // Check for a profile, given the user ID
        db.collection("users").document(userId).getDocument { (snapshot, error) in
            
            if error != nil || snapshot == nil {
                // error or something wrong with data
                return
            }
            
            if let profile = snapshot!.data() {
                
                // Profile was found, create a new Photo user
                var u = PhotoUser()
                u.userID = snapshot!.documentID
                u.username = profile["username"] as? String
                
                // Return the user
                completion(u)
                
            }else {
                
                // Couldn't get profile, no profile
                
                // Return nil
                completion(nil)
                
            }
            
        }
        
    }
    
}
