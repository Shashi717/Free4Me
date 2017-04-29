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
    
    func getItems(completion: @escaping ([Freebie]) -> Void) {
        
        self.databaseRef.child("freebies").observe(.value, with: {(snapshot) in
            
            var freebieArr: [Freebie] = []
            
            for item in snapshot.children {
              self.getItem(id: (item as AnyObject).key, completion: { (freebie) in
                freebieArr.append(freebie)
              })
            }
//            let id = snapshot.key
//            
//            if let name = snapshot.childSnapshot(forPath: "name").value as? String,
//                let category = snapshot.childSnapshot(forPath: "category").value as? String,
//                let image = snapshot.childSnapshot(forPath: "image").value as? String,
//                let ownerId = snapshot.childSnapshot(forPath: "ownerId").value as? String,
//                let borough = snapshot.childSnapshot(forPath: "borough").value as? String,
//                let expiration = snapshot.childSnapshot(forPath: "expiration").value as? String {
//                
//                
//                let freebie = Freebie(id: id,
//                                      name: name,
//                                      image: image,
//                                      category: category,
//                                      ownerId: ownerId,
//                                      borough: borough,
//                                      expiration: expiration
//                )
//                freebieArr.append(freebie)
//            }
            
            completion(freebieArr)
            return
            
            
        })
    }
    func getItem(id: String, completion: @escaping (Freebie) -> Void) {
        
        self.databaseRef.child("freebies").child(id).observe(.value, with: {(snapshot) in
            
            var freebie: Freebie?
            let id = snapshot.key
            
            if let name = snapshot.childSnapshot(forPath: "name").value as? String,
                let category = snapshot.childSnapshot(forPath: "category").value as? String,
                let image = snapshot.childSnapshot(forPath: "image").value as? String,
                let ownerId = snapshot.childSnapshot(forPath: "ownerId").value as? String,
                let borough = snapshot.childSnapshot(forPath: "borough").value as? String,
                let expiration = snapshot.childSnapshot(forPath: "expiration").value as? String {
                
                
                freebie = Freebie(id: id,
                                  name: name,
                                  image: image,
                                  category: category,
                                  ownerId: ownerId,
                                  borough: borough,
                                  expiration: expiration
                )
                
            }
            if let freebie = freebie {
                completion(freebie)
                return
            }
            
        })
    }
    
    
    
    
}
