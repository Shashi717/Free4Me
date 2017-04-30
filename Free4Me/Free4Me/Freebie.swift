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
    
    let id: String
    let name: String
    let image: String
    let category: String
    let ownerId: String
    let borough: String
    let expiration: String
    
    init(id: String, name: String, image: String, category: String, ownerId: String, borough: String, expiration: String) {
        self.id = id
        self.name = name
        self.image = image
        self.category = category
        self.ownerId = ownerId
        self.borough = borough
        self.expiration = expiration
    }
    
}
