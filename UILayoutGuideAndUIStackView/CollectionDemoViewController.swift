//
//  CollectionDemoViewController.swift
//  UILayoutGuideAndUIStackView
//
//  Created by Bart van Kuik on 28/07/2018.
//  Copyright © 2018 DutchVirtual. All rights reserved.
//

import UIKit

class CollectionDemoViewController: UIViewController, UICollectionViewDataSource {
    private let collectionView: UICollectionView
    private let collectionViewCellIdentifier = "DynamicTextCollectionViewCell"

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return globalData[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return globalData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewCellIdentifier, for: indexPath) as? DynamicTextCollectionViewCell else {
            fatalError()
        }
        let string = globalData[indexPath.section][indexPath.row]
        cell.text = string
        
        return cell
    }

    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.dataSource = self
        self.collectionView.register(DynamicTextCollectionViewCell.self, forCellWithReuseIdentifier: self.collectionViewCellIdentifier)
        self.view.addSubview(self.collectionView)

        let guide = self.view.safeAreaLayoutGuide
        let constraints = [
            self.collectionView.leadingAnchor.constraintEqualToSystemSpacingAfter(guide.leadingAnchor, multiplier: 1),
            self.collectionView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1),
            guide.trailingAnchor.constraintEqualToSystemSpacingAfter(self.collectionView.trailingAnchor, multiplier: 1),
            guide.bottomAnchor.constraintEqualToSystemSpacingBelow(self.collectionView.bottomAnchor, multiplier: 1)
        ]
        self.view.addConstraints(constraints)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("not supported")
    }
    
    required init?(coder aDecoder: NSCoder) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        self.collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        
        super.init(coder: aDecoder)
        self.tabBarItem.title = "Collection View"
    }
}
