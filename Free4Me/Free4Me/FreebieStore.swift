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
        
        var freebieArr: [Freebie] = []
        
        self.databaseRef.child("freebies").observe(.value, with: {(snapshot) in
            
            for item in snapshot.children.allObjects as! [FIRDataSnapshot] {
                
                var expiration = "N/A"
                if let name = item.childSnapshot(forPath: "name").value as? String,
                    let category = item.childSnapshot(forPath: "category").value as? String,
                    let image = item.childSnapshot(forPath: "image").value as? String,
                    let ownerId = item.childSnapshot(forPath: "ownerId").value as? String,
                    let borough = item.childSnapshot(forPath: "borough").value as? String {
                    
                    if let expirationDate = item.childSnapshot(forPath: "expiration").value as? String {
                        expiration = expirationDate
                    }
                    
                    let freebie = Freebie(id: item.key,
                                          name: name,
                                          image: image,
                                          category: category,
                                          ownerId: ownerId,
                                          borough: borough,
                                          expiration: expiration
                    )
                    freebieArr.append(freebie)
                }
                
            }
            
            print(freebieArr.count)
            completion(freebieArr)
            
        })
    }
    
    func getItem(id: String, completion: @escaping (Freebie) -> Void) {
        
        self.databaseRef.child("freebies").child(id).observe(.value, with: {(snapshot) in
            
            var freebie: Freebie?
            let id = snapshot.key
            
            var expiration = "N/A"
            
            if let name = snapshot.childSnapshot(forPath: "name").value as? String,
                let category = snapshot.childSnapshot(forPath: "category").value as? String,
                let image = snapshot.childSnapshot(forPath: "image").value as? String,
                let ownerId = snapshot.childSnapshot(forPath: "ownerId").value as? String,
                let borough = snapshot.childSnapshot(forPath: "borough").value as? String {
                
                if let expirationDate = snapshot.childSnapshot(forPath: "expiration").value as? String {
                    expiration = expirationDate
                }
                
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
