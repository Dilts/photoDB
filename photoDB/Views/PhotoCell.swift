//
//  PhotoCell.swift
//  photoDB
//
//  Created by Brian Dilts on 5/24/21.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var photo:Photo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayPhoto(photo:Photo) {
        
        // Reset the image
        self.photoImageView.image = nil
        
        // Set photo property
        self.photo = photo
        
        // Set the username
        usernameLabel.text = photo.byUsername
        
        // Set the date
        dateLabel.text = photo.date
        
        // Check that there is a valid download url
        if photo.url == nil {
            return
        }
        
        // Check if the image is in cache, if it is use it
        if let cachedImage = ImageCacheService.getImage(url: photo.url!) {
            
            // Use the cached image
            self.photoImageView.image = cachedImage
            // Return becasue we no longer need to download the image
            return
            
        }
        
        // Download the image
        let url = URL(string: photo.url!)
        
        // Check that url object was created
        if url == nil {
            return
        }
        
        // Use url session to download the image async
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check for errors and data
            if error == nil || data != nil {
                
                // Set the image view
                let image = UIImage(data: data!)
                
                // Store the image data in cache
                ImageCacheService.saveImage(url: url!.absoluteString, image: image)
                
                // Check that the image data that wwe downloaded matches the photo that this cell is currently supposed to display
                if url!.absoluteString != self.photo?.url! {
                    // The url we downloaded doesnt match the url we are currently displaying
                    return
                }
                
                // Set the image view
                DispatchQueue.main.async {
                    
                    self.photoImageView.image = image
                    
                }
                
            }
            
        } // end of dataTask
        dataTask.resume()
    } // End of displayPhoto method
    

}
