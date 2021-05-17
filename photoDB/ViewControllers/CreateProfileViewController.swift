//
//  CreateProfileViewController.swift
//  photoDB
//
//  Created by Brian Dilts on 5/17/21.
//

import UIKit
import FirebaseAuth

class CreateProfileViewController: UIViewController {

    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func confirmTapped(_ sender: Any) {
        
        // Check that there is a user logged in
        guard Auth.auth().currentUser != nil else {
            // No user logged in
            return
        }
        
        // Get the username and check it against whitespace, new lines, illegal characters etc.
        let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if username == nil || username == "" {
            // Show an error message and return (try UIAlertController)
            return
        }
        
        // Call the user service to create the profile
        UserService.createProfile(userId: Auth.auth().currentUser!.uid, username: username!) { (user) in
            
            // Check if it was created successfully
            if user != nil {
                // If so, save user to local storage and go to the tab bar controller
                LocalStorageService.saveUser(userId: user!.userID, username: user!.username)
                
                let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                
                self.view.window?.rootViewController = tabBarVC
                self.view.window?.makeKeyAndVisible()
                
            } else {
                // If not, display error
            }
            
        } // End of UserService call
        
    } // End of confirmTapped method
    
    
} // End of Create Profile class
