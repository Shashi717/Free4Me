//
//  FreebiesCollectionViewCell.swift
//  Free4Me
//
//  Created by Madushani Lekam Wasam Liyanage on 4/29/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class FreebiesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var freebieImageView: UIImageView!
    @IBOutlet weak var freebieName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .white
        freebieName.layer.shadowRadius = 2
        freebieName.layer.shadowOffset = CGSize(width: 0, height: 3)
        freebieName.layer.shadowOpacity = 0.2
    }

}
