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
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!

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
            cell.configureCell(post: post)
            return cell
        } else {
            return PostCell()
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImage.image = image
        } else {
            print("RESULT: Image not selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }


    @IBAction func selectImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func signOutTapped(_ sender: Any) {
        
        let removeResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        print("RESULT: ID removed from Keychain \(removeResult)")
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    

}
