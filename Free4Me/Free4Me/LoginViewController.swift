//
//  LoginViewController.swift
//  Free4Me
//
//  Created by Madushani Lekam Wasam Liyanage on 4/29/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController, UIAlertViewDelegate {
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var boroughTextField: UITextField!
    
    var databaseRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = FIRDatabase.database().reference()
        loginCheck()
        
    }
    
    func loginCheck() {
        if FIRAuth.auth()?.currentUser != nil {
            //            let tabs = UITabBarController()
            //            tabs.viewControllers = [FreebiesViewController(), PostViewController(), SettingsViewController()]
            //            self.present(tabs, animated: true, completion: nil)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tbvc = storyboard.instantiateViewController(withIdentifier: "TabBarVC")
            self.present(tbvc, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if let error = error {
                    print("User Login Error \(error.localizedDescription)")
                    let alertController = showAlert(title: "Login Failed!", message: "Failed to Login. Please Check Your Email and Password!", useDefaultAction: true)
                    
                    self.present(alertController, animated: true, completion: nil)
                    self.clearTextFields()
                }
                else {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tbvc = storyboard.instantiateViewController(withIdentifier: "TabBarVC")
                    let alertController = UIAlertController(title: "Login Successful!", message: nil, preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: nil)
                    self.clearTextFields()
                    
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        self.present(tbvc, animated: true, completion: nil)
                    }))
                    
                }
            })
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text,
            let password = passwordTextField.text,
            let name = userNameTextField.text,
            let borough = boroughTextField.text {
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if let error = error {
                    print("User Creating Error \(error.localizedDescription)")
                    let alertController = showAlert(title: "Signup Failed!", message: "Failed to Register. Please Try Again!", useDefaultAction: true)
                    self.present(alertController, animated: true, completion: nil)
                    self.clearTextFields()
                }
                else {
                    let alertController = showAlert(title: "Signup Successful!", message: "Successfully Registered. Please Login to Use Our App!", useDefaultAction: true)
                    
                    let postDict = ["name": name, "email": email, "borough": borough] as [String:Any]
                    
                    let currentUser = FIRAuth.auth()?.currentUser?.uid
                    self.databaseRef.child("users").child(currentUser!).setValue(postDict)
                    self.present(alertController, animated: true, completion: nil)
                    self.clearTextFields()
                }
            })
        }
    }
    
    func clearTextFields() {
        emailTextField.text = nil
        passwordTextField.text = nil
        userNameTextField.text = nil
        boroughTextField.text = nil
    }
    
}
