//
//  FeedVC.swift
//  FirebaseNetwork
//
//  Created by Lucheo Antonio Tombini Filho on 22/12/16.
//  Copyright © 2016 Lucheo Antonio Tombini Filho. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var addImage: CircleImgView!
    
    @IBOutlet weak var captionField: MaterialTextField!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    var imageSelected: Bool = false
    
    //static let imageCache: Cache <NSString, UIImage> = Cache()
    static let imageCache: NSCache<NSString, UIImage> = NSCache()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTable.delegate = self
        mainTable.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        DataService.ds.Ref_Posts.observe(.value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.mainTable.reloadData()
        })
        


    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let post = posts[indexPath.row]
        if let cell = mainTable.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                cell.configureCell(post: post, img: nil)
                return cell
            }
            
            
        } else {
            return PostCell()
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImage.image = image
            imageSelected = true
        } else {
            print("RESULT: Image not selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }


    @IBAction func selectImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func postTapped(_ sender: Any) {
        guard let caption = captionField.text, caption != "" else {
            print("RESULT: caption must be entered")
            return
        }
        
        guard let img = addImage.image, imageSelected == true else {
            print("RESULT: an image must be selected")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            let imgUid = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.ds.Ref_Posts_Images.child(imgUid).put(imgData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("RESULT: Unable to upload image to Firebase")
                } else {
                    print("RESULT: Succesfully uploaded image to Firebase")
                    let downloadUrl = metadata?.downloadURL()?.absoluteString
                    if let url = downloadUrl {
                        self.uploadToFirebase(imgUrl: url)
                    }
                    
                }
            }
        }
    }
    
    func uploadToFirebase(imgUrl: String) {
        let post: Dictionary<String, AnyObject> = [
        "caption": captionField.text as AnyObject,
        "imageUrl": imgUrl as AnyObject,
        "likes": 0 as AnyObject
        ]
        let firebasePost = DataService.ds.Ref_Posts.childByAutoId()
        firebasePost.setValue(post)
        
        mainTable.reloadData()
        
        captionField.text = ""
        imageSelected = false
        addImage.image = #imageLiteral(resourceName: "add-image")
        
        
        
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        
        let removeResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        print("RESULT: ID removed from Keychain \(removeResult)")
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    

}
