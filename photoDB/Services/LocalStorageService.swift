//
//  LocalStorageService.swift
//  photoDB
//
//  Created by Brian Dilts on 5/17/21.
//

import Foundation

class LocalStorageService {
    
    static func saveUser(userId:String?, username:String?) {
        
        // Get a reference to user defaults
        let defaults = UserDefaults.standard
        
        // Save the userid and username to defaults
        defaults.set(userId, forKey: Constants.LocalStorage.userIdKey)
        defaults.set(username, forKey: Constants.LocalStorage.usernameKey)
        
    } // End of saveUser method
    
    static func loaduser() -> PhotoUser? {
        
        // Get a reference to user defaults
        let defaults = UserDefaults.standard
        
        // Get the username and id
        let username = defaults.value(forKey: Constants.LocalStorage.usernameKey) as? String
        let userId = defaults.value(forKey: Constants.LocalStorage.userIdKey) as? String
        
        // Return the result
        if userId != nil && username != nil {
            // Return saved user
            return PhotoUser(userID: userId, username: username)
        } else {
            // Either userId or username couldn't be retrieved so return nil
            return nil
        }
        
    } // End of loadUser method
    
    static func clearUser() {
        
        // Get a reference to user defaults
        let defaults = UserDefaults.standard
        
        // Clear the values for the keys
        defaults.setValue(nil, forKey: Constants.LocalStorage.userIdKey)
        defaults.setValue(nil, forKey: Constants.LocalStorage.usernameKey)
        
    }
    
}
