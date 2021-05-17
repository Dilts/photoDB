//
//  SettingsViewController.swift
//  photoDB
//
//  Created by Brian Dilts on 5/17/21.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOutTapped(_ sender: Any) {
        
        // Signout with Firebase Auth
        do {
            // Try to signout user
            try Auth.auth().signOut()
            
            // Clear local storage
            LocalStorageService.clearUser()
            
            // Transition to authentication flow
            let loginNavVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginNavController)
            
            self.view.window?.rootViewController = loginNavVC
            self.view.window?.makeKeyAndVisible()
            
        }
        catch {
            // Couldn't signout user
        }
        
    }
    

}
