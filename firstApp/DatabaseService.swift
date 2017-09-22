//
//  DatabaseService.swift
//  firstApp
//
//  Created by Leandro Gartner on 10/9/17.
//  Copyright © 2017 Leandro Gartner. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DatabaseService {
    
    private static let _shared = DatabaseService()
    
    static var shared : DatabaseService {
        return _shared
    }
    
    var mainRef : DatabaseReference {
        return Database.database().reference()
    }
    
    var textRef : DatabaseReference {
        return mainRef.child("text")
    }
    
    var mainStorageRef : StorageReference {
        return Storage.storage().reference(forURL: "FIREBASE_DB_URL")
    }
    
    func saveText(text : String) {
        self.mainRef.child("text").childByAutoId().setValue(text)
    }
    
}
