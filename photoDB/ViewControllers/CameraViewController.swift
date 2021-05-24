//
//  CameraViewController.swift
//  photoDB
//
//  Created by Brian Dilts on 5/17/21.
//

import UIKit

class CameraViewController: UIViewController {

    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Hide and reset all elements 
        progressBar.alpha = 0
        progressBar.progress = 0
        doneButton.alpha = 0
        progressLabel.alpha = 0
        
    }
    

    func savePhoto(image:UIImage) {
        
        // Call the phtoto service to store the photo
        PhotoService.savePhoto(image: image) { (pct) in
            
            DispatchQueue.main.async {
                
                // Update the progress bar
                self.progressBar.alpha = 1
                self.progressBar.progress = Float(pct)
                
                // Update the label
                let roundedPct = Int(pct * 100)
                self.progressLabel.text = "\(roundedPct) %"
                self.progressLabel.alpha = 1
                
                // Check if it is done
                if pct == 1 {
                    self.doneButton.alpha = 1
                }
                
            } // End DispatchQueue
            
        } // End of call to photo service
        
    } // End of savePhoto method

    @IBAction func doneTapped(_ sender: Any) {
        
        // Get a reference to the tab bar controller
        let tabBarVC = self.tabBarController as? MainTabBarController
        
        if let tabBarVC = tabBarVC {
            
            // Call goToFeed
            tabBarVC.goToFeed()
            
        }
        
    }
    
    
} // End of class
