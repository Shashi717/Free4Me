//
//  FreebiesViewController.swift
//  Free4Me
//
//  Created by Madushani Lekam Wasam Liyanage on 4/29/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class FreebiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var boroSegmentedControl: UISegmentedControl!
    @IBOutlet weak var freebiesCollectionView: UICollectionView!
    
    var itemsArr: [Freebie] = []
    var boroughs = ["All", "Bronx", "Brooklyn", "Manhattan", "Queens"]
    var selectedCategory = ""
    var selectedBorough = "all"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(selectedCategory)
        freebiesCollectionView.delegate = self
        freebiesCollectionView.dataSource = self
        
        let nib = UINib(nibName: "FreebiesCollectionViewCell", bundle:nil)
        freebiesCollectionView.register(nib, forCellWithReuseIdentifier: "freebieCell")
      
    }

    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = freebiesCollectionView.dequeueReusableCell(withReuseIdentifier: "freebieCell", for: indexPath) as! FreebiesCollectionViewCell
        
        cell.freebieName.text = ""
        
        return cell
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        
        selectedBorough = boroughs[boroSegmentedControl.selectedSegmentIndex]
        
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
