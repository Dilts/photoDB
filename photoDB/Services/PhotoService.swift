//
//  PhotoService.swift
//  photoDB
//
//  Created by Brian Dilts on 5/17/21.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class PhotoService {
    
    static func retrievePhotos(completion: @escaping ([Photo]) -> Void ) {
        
        // Get a db reference
        let db = Firestore.firestore()
        
        // Get all of the documents from the photos collection
        db.collection("photos").getDocuments { (snapshot, error) in
            
            // Check for errors
            if error != nil {
                // Error in returning photos
                return
            }
            
            // get all the documents
            let documents = snapshot?.documents
            
            // Check that docs aren't nil
            if let documents = documents {
                
                // Create an array to hold all of our photo structs
                var photoArray = [Photo]()
                
                // Loop through the docs, create a photo struct for each
                for doc in documents {
                    
                    // Create photo struct
                    let p = Photo(snapshot: doc)
                    
                    if p != nil {
                        
                        // Store it in our array
                        photoArray.insert(p!, at: 0)
                        
                    }
                    
                } // End loop
                
                // Pass back photoArray
                completion(photoArray)
            }
            
            // Parse the documents into photo structs
            
        }
        
    } // End retrivePhotos method
    
    static func savePhoto(image:UIImage, progressUpdate: @escaping (Double) -> Void ) {
        
        // Check that there is a user logged in
        if Auth.auth().currentUser == nil {
            return
        }
        
        // Get the data representation of the UIImage
        let photoData = image.jpegData(compressionQuality: 0.1)
        
        guard photoData != nil else {
            // Error, no photo data
            return
        }
        
        // Create a filename
        let filename = UUID().uuidString
        
        // Get the user id of the current user
        let userId = Auth.auth().currentUser!.uid
        
        // Create a firebase storage reference
        let ref = Storage.storage().reference().child("images/\(userId)/\(filename).jpg")
        
        // Upload the data
        let uploadTask = ref.putData(photoData!, metadata: nil) { (metadata, error) in
            
            // Check that upload was successful
            if error == nil {
                
                // Upon successful upload, create the database entry
                self.createDatabaseEntry(ref: ref)
            }
            
        }
        
        uploadTask.observe(.progress) { (taskSnapshot) in
            
            let pct = Double(taskSnapshot.progress!.completedUnitCount) / Double(taskSnapshot.progress!.totalUnitCount) 
            print("The upload progress is \(pct)")
            progressUpdate(pct)
            
        }
        
    } // End of savePhoto method
    
    private static func createDatabaseEntry(ref: StorageReference) {
        
        // Download url
        ref.downloadURL { (url, error) in
            
            // If there is no error than proceed
            if error == nil {
                
                // Photo id
                let photoId = ref.fullPath
                
                // Get the current user
                let photoUser = LocalStorageService.loaduser()
                
                // UserId
                let userId = photoUser?.userID
                
                // Username
                let username = photoUser?.username
                
                // Date
                let df = DateFormatter()
                df.dateStyle = .full
                
                let dateString = df.string(from: Date())
                
                // Create a dictionary of the photo metadata
                let metadata = ["photoId":photoId, "byId":userId!, "byUsername":username!, "date":dateString, "url":url!.absoluteString ]
                
                // Save the metadate to the firestore db
                let db = Firestore.firestore()
                
                db.collection("photos").addDocument(data: metadata) { (error) in
                    
                    // Check if the saving of data was successful
                    if error == nil {
                        
                        // Successfully created database entry for the photo
                        
                    }
                    
                } // End DB completion handler
                
            } // End big if
            
        } // End downloadURL method
        
    } // End createDatabaseEntry method
    
    
} // End of class
