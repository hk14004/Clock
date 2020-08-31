//
//  StopwatchFaceCollectionViewController.swift
//  Clock
//
//  Created by Hardijs on 31/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class StopwatchFaceCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .red
        collectionView?.register(StopwatchDigitalClockFaceCell.self, forCellWithReuseIdentifier: "digitalCell")
        collectionView?.register(StopwatchAnalogClockFaceCell.self, forCellWithReuseIdentifier: "analogCell")
        collectionView?.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        
        if indexPath.row == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "digitalCell", for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "analogCell", for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
