//
//  FeedViewController.swift
//  photoDB
//
//  Created by Brian Dilts on 5/17/21.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Call the photoService to retrieve the photos
        PhotoService.retrievePhotos { (retrievedPhotos) in
            
            // Set our photos array to the retrieved photos
            self.photos = retrievedPhotos
            
            // Tell the tableView to reload
            self.tableView.reloadData()
            
        }
    }
    

}
