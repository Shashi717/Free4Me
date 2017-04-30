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
    }

}
