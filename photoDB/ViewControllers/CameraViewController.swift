//
//  CameraViewController.swift
//  photoDB
//
//  Created by Brian Dilts on 5/17/21.
//

import UIKit

class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func savePhoto(image:UIImage) {
        
        // Call the phtoto service to store the photo
        PhotoService.savePhoto(image: image)
        
    }

}
