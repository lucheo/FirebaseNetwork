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

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signOutTapped(_ sender: Any) {
        
        let remove = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        print("RESULT: ID removed from Keychain \(remove)")
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    

}
