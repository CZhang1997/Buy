//
//  HomePageViewController.swift
//  Buy?
//
//  Created by Xizhen Yang on 2/26/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let largeImage = [UIImage(named: "SaleTaxImage"),UIImage(named: "TipImage")]
    let largeLable = ["算税","小费"]
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let largeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "largeCell", for: indexPath) as! LargeCollectionViewCell
        
        let cellIndex = indexPath.item
        
        largeCell.Image.image = largeImage[cellIndex]
        //largeCell.Image.
        largeCell.Label.text = largeLable[cellIndex]
        
        
        largeCell.contentView.layer.cornerRadius = 2
        largeCell.contentView.layer.borderWidth = 2.0
    
        
        largeCell.contentView.layer.borderColor = UIColor.black.cgColor
        largeCell.contentView.layer.masksToBounds = true
        largeCell.backgroundColor = UIColor.white
//        cell.contentView.layer.borderColor = UIColor.blue.cgColor
//        cell.contentView.layer.masksToBounds = true
//        cell.backgroundColor = UIColor.white
//
//        cell.layer.shadowColor = UIColor.gray.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        cell.layer.shadowRadius = 2.0
//        cell.layer.shadowOpacity = 1.0
//        cell.layer.masksToBounds = false
//        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
//
//
        return largeCell
        
    }
    

    
    
    
    

    @IBOutlet weak var WelcomeMessage: UILabel!
    @IBOutlet weak var SelectionCollenctionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SelectionCollenctionView.delegate = self
        SelectionCollenctionView.dataSource = self
        //SelectionCollenctionView.backgroundView?.backgroundColor = UIColor.darkGray
        
       
    }
    

   
}

//extension HomePageViewController : UICollectionViewDelegateFlowLayout {
//
//}
