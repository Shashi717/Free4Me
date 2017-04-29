//
//  User.swift
//  Free4Me
//
//  Created by Madushani Lekam Wasam Liyanage on 4/29/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

class User {
    
    let id: String
    let name: String
    let email: String
    let borough: String
    
    init(id: String, name: String, email: String, borough: String) {
        self.id = id
        self.name = name
        self.email = email
        self.borough = borough
    }
    
}
