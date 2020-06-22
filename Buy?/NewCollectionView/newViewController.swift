//
//  newViewController.swift
//  Buy?
//
//  Created by Xizhen Yang on 2/26/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import UIKit

class newViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var new: UICollectionView!
    @IBOutlet weak var nextPageButton: UIButton!
    
    var largeImage = [UIImage(named: "SaleTaxImage"),UIImage(named: "TipImage")]
    var largeLabel = [("算税"), ("小费")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        new.delegate = self
        new.dataSource = self
    }
    

    // UICollectionViewDelegate, UICollectionViewDataSource functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        
        let cellIndex = indexPath.item
        cell.imageView.image = largeImage[cellIndex]
        cell.Lable.text = largeLabel[cellIndex]
        
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
