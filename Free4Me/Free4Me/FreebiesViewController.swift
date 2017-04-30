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
    var bronxItems: [Freebie] = []
    var brooklynItems: [Freebie] = []
    var manhattanItems: [Freebie] = []
    var queensItems: [Freebie] = []
    var boroughs = ["All", "Bronx", "Brooklyn", "Manhattan", "Queens"]
    var selectedCategory = "Other"
    var selectedBorough = "All"
    var freebieStore: FreebieStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        freebiesCollectionView.delegate = self
        freebiesCollectionView.dataSource = self
        
        let nib = UINib(nibName: "FreebiesCollectionViewCell", bundle:nil)
        freebiesCollectionView.register(nib, forCellWithReuseIdentifier: "freebieCell")
        
        freebieStore = FreebieStore()
        freebieStore?.getItems(completion: { (freebieArr) in
            self.itemsArr = freebieArr
            self.freebiesCollectionView.reloadData()
            
            self.sortItemsByBorough(freebieArr)
        })
        
    }
    
    func sortItemsByBorough(_ arr: [Freebie]) {
        for item in arr {
            switch item.borough {
            case "Bronx":
                bronxItems.append(item)
            case "Brooklyn":
                brooklynItems.append(item)
            case "Manhattan":
                manhattanItems.append(item)
            case "Queens":
                queensItems.append(item)
            default:
                break
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = freebiesCollectionView.dequeueReusableCell(withReuseIdentifier: "freebieCell", for: indexPath) as! FreebiesCollectionViewCell
        let item = itemsArr[indexPath.row]
        
        cell.freebieName.text = item.name
        
        let imageStr = item.image
        
        APIRequestManager.manager.getData(endPoint: imageStr) { (data) in
            if let validData = data, let validImage = UIImage(data: validData) {
                cell.freebieImageView.image = validImage
                self.freebiesCollectionView.reloadData()
            }
        }
        
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
