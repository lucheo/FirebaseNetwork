//
//  ViewController.swift
//  FirebaseNetwork
//
//  Created by Lucheo Antonio Tombini Filho on 24/11/16.
//  Copyright © 2016 Lucheo Antonio Tombini Filho. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fbBtnPressed(_ sender: UIButton) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("RESULT: Unable to authenticate with Facebook - \(error)")
                
            } else if result?.isCancelled == true {
                print("RESULT: User canceled Facebook Authentication")
                
            } else {
                print("RESULT: Authentication successful")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuthentication(credential)
            }
        }
    }
    
    func firebaseAuthentication(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("RESULT: Unable to authenticate with Firebase -\(error)")
            } else {
                print("RESULT: Succesfully autheticated with Firebase")
            }
        })
    }
       
        
}

