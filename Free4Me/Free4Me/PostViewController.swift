//
//  PostViewController.swift
//  Free4Me
//
//  Created by Madushani Lekam Wasam Liyanage on 4/29/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

//let name: String
//let image: String
//let category: String
//let ownerId: String
//let borough: String
//let expiration: String

class PostViewController: UIViewController {
    
    var user: User?
    var databaseRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    
    func postToFirebase() {
        
        if let userId = FIRAuth.auth()?.currentUser?.uid {
            var expiration = "N/A"
            //            if let name = "" ,
            //            let image = "",
            //            let category = "",
            //            let ownerId = "",
            
            let freebieDict = ["name": "", "image": "", "category": "", "ownerId": userId, "borough": "", "expiration":expiration] as [String:Any]
            let postDict = ["name": "", "image": "", "category": "", "expiration":expiration] as [String:Any]
            self.databaseRef.child("freebies").childByAutoId().setValue(freebieDict)
            self.databaseRef.child((FIRAuth.auth()?.currentUser?.uid)!).setValue(postDict)
            
        }
        else {
            print("not signed in")
            let alertController = showAlert(title: "Not signed in!", message: "You need to sign in to post an item. Would you like to be directed to the login page?", useDefaultAction: false)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                //go the login page
                
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
                
                self.dismiss(animated: true, completion: nil)
                
            }))
            self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
public func showAlert(title: String, message: String?, useDefaultAction: Bool) -> UIAlertController {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    if useDefaultAction {
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
    }
    
    return alertController
}


