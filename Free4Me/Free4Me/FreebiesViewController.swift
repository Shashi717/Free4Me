//
//  FreebiesViewController.swift
//  Free4Me
//
//  Created by Madushani Lekam Wasam Liyanage on 4/29/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit
import MessageUI

class FreebiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MFMailComposeViewControllerDelegate {
    
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
            self.sortItemsByBorough(freebieArr)
            print(self.itemsArr)
            self.freebiesCollectionView.reloadData()
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
                
                DispatchQueue.main.async {
                    cell.freebieImageView.image = validImage
                }
                
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        
        selectedBorough = boroughs[boroSegmentedControl.selectedSegmentIndex]
        
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["tsyrema@gmail.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
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
