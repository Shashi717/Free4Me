//
//  Freebie.swift
//  Free4Me
//
//  Created by Madushani Lekam Wasam Liyanage on 4/29/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

enum Borough {
    case all
    case bronx
    case brooklyn
    case manhattan
    case queens
}

enum Category {
    case books
    case furniture
    case other
}

import Foundation

class Freebie {
    
    let name: String
    let category: Category
    let owner: User
    let borough: Borough
    let expiration: String
    
    init(name: String, category: Category, owner: User, borough: Borough, expiration: String) {
        self.name = name
        self.category = category
        self.owner = owner
        self.borough = borough
        self.expiration = expiration
    }
    
}
