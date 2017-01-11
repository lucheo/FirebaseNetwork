//
//  DataService.swift
//  FirebaseNetwork
//
//  Created by Lucheo Antonio Tombini Filho on 10/01/17.
//  Copyright © 2017 Lucheo Antonio Tombini Filho. All rights reserved.
//

import Foundation
import Firebase
let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    //DB references
    private var _Ref_Base = DB_BASE
    private var _Ref_Posts = DB_BASE.child("posts")
    private var _Ref_Users = DB_BASE.child("users")
    
    //Storage references
    private var _Ref_Posts_Images = STORAGE_BASE.child("postPics")
    
    var Ref_Base: FIRDatabaseReference {
        return _Ref_Base
    }
    
    var Ref_Posts: FIRDatabaseReference {
        return _Ref_Posts
    }
    
    var Ref_Users: FIRDatabaseReference {
        return _Ref_Users
        
    }
    
    var Ref_Posts_Images: FIRStorageReference {
        return _Ref_Posts_Images
    }
    
    func createFirebaseDBuser(uid: String, userData: Dictionary<String, String>) {
        Ref_Users.child(uid).updateChildValues(userData)
        
    }

    
    
    
}
