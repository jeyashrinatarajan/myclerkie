//
//  ChartViewController.swift
//  My Clerkie
//
//  Created by Jeyashri Natarajan on 11/19/17.
//  Copyright © 2017 Clerkie. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet var chartCollectionView: UICollectionView!
    
    fileprivate let pictureCellReuseIdentifier = "ChartCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pictureCellReuseIdentifier, for: indexPath as IndexPath)
        cell.backgroundColor = UIColor.cyan // just so cell is visible for now
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
