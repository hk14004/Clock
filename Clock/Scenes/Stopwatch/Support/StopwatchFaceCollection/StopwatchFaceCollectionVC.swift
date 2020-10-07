//
//  StopwatchFaceCollectionViewController.swift
//  Clock
//
//  Created by Hardijs on 31/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class StopwatchFaceCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private lazy var pageControl: UIPageControl = UIPageControl()
    
    private(set) var digitalClockCell: StopwatchDigitalClockFaceCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.register(StopwatchDigitalClockFaceCell.self, forCellWithReuseIdentifier: "digitalCell")
        collectionView.register(StopwatchAnalogClockFaceCell.self, forCellWithReuseIdentifier: "analogCell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        setupPageControl()
    }
    
    @objc private func pageControlTapHandler(sender:UIPageControl) {
        collectionView.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlTapHandler(sender:)), for: .touchUpInside)
        
        view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        pageControl.currentPage = Int(ceil(x/w))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageControl.numberOfPages
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        
        if indexPath.row == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "digitalCell", for: indexPath)
            digitalClockCell = cell as? StopwatchDigitalClockFaceCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "analogCell", for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
