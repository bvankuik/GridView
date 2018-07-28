//
//  GridViewController.swift
//  UILayoutGuideAndUIStackView
//
//  Created by Bart van Kuik on 27/07/2018.
//  Copyright © 2018 DutchVirtual. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {
    override func viewDidLoad() {
        guard let nCols = globalData.first?.count else {
            fatalError()
        }
        
        let gridView = GridView(columns: nCols)
        gridView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(gridView)
        
        let labelData: [[UILabel]] = globalData.map {
            let labels: [UILabel] = $0.map {
                let label = UILabel()
                label.font = UIFont.preferredFont(forTextStyle: .body)
                label.text = $0
                label.backgroundColor = .black
                label.textColor = .white
                return label
            }
            return labels
        }

        labelData.forEach {
            gridView.addRow($0)
        }
        
        let guide = self.view.safeAreaLayoutGuide
        let constraints = [
            gridView.leadingAnchor.constraintEqualToSystemSpacingAfter(guide.leadingAnchor, multiplier: 1),
            gridView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1),
            guide.trailingAnchor.constraintEqualToSystemSpacingAfter(gridView.trailingAnchor, multiplier: 1)
        ]
        self.view.addConstraints(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tabBarItem.title = "Grid View"
    }
}
