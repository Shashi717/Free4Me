//
//  FreebieStore.swift
//  Free4Me
//
//  Created by Madushani Lekam Wasam Liyanage on 4/29/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FreebieStore {
    
    var databaseRef = FIRDatabase.database().reference()
    
    func getItem(id: String, completion: @escaping ([Freebie]) -> Void) {
        
        self.databaseRef.child("freebies").child(id).observe(.value, with: {(snapshot) in
            
            var freebieArr: [Freebie] = []
            
            let id = snapshot.key
            
            if let name = snapshot.childSnapshot(forPath: "name").value as? String,
                let category = snapshot.childSnapshot(forPath: "category").value as? String,
                let image = snapshot.childSnapshot(forPath: "image").value as? String,
                let ownerId = snapshot.childSnapshot(forPath: "ownerId").value as? String,
                let borough = snapshot.childSnapshot(forPath: "borough").value as? String,
                let expiration = snapshot.childSnapshot(forPath: "expiration").value as? String {
                
                
                let freebie = Freebie(id: id,
                                      name: name,
                                      image: image,
                                      category: category,
                                      ownerId: ownerId,
                                      borough: borough,
                                      expiration: expiration
                )
                freebieArr.append(freebie)
            }
            
            completion(freebieArr)
            return
            
            
        })
    }
    
    
    
    
}
