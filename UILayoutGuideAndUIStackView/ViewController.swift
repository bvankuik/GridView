//
//  ViewController.swift
//  UILayoutGuideAndUIStackView
//
//  Created by Bart van Kuik on 27/07/2018.
//  Copyright © 2018 DutchVirtual. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let data = [
        ["Lorem", "ipsum", "dolor", "sit", "amet", "consectetur"],
        ["adipiscing", "elit", "sed", "do", "eiusmod", "tempor"],
        ["incididunt", "ut", "labore", "et", "dolore", "magna"],
        ["aliqua", "Ut", "enim", "ad", "minim", "veniam"],
        ["quis", "nostrud", "exercitation", "ullamco", "laboris", "nisi"],
        ["ut", "aliquip", "ex", "ea", "commodo", "consequat"],
        ["Duis", "aute", "irure", "dolor", "in", "reprehenderit"],
        ["in", "voluptate", "velit", "esse", "cillum", "dolore"],
        ["eu", "fugiat", "nulla", "pariatur", "Excepteur", "sint"],
        ["occaecat", "cupidatat", "non", "proident", "sunt", "in"],
        ["culpa", "qui", "officia", "deserunt", "mollit", "anim"]
    ]

    override func viewDidLoad() {
        guard let nCols = self.data.first?.count else {
            fatalError()
        }
        let gridView = GridView(columns: nCols)
        gridView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(gridView)
        
        if let firstDataRow = self.data.first {
            let labels: [UILabel] = firstDataRow.map {
                let label = UILabel()
                label.font = UIFont.preferredFont(forTextStyle: .body)
                label.text = $0
                label.backgroundColor = .black
                label.textColor = .white
                return label
            }
            gridView.addRow(labels)
        }
        
        let guide = self.view.safeAreaLayoutGuide
        let constraints = [
            gridView.leadingAnchor.constraintEqualToSystemSpacingAfter(guide.leadingAnchor, multiplier: 1),
            gridView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1),
            guide.trailingAnchor.constraintEqualToSystemSpacingAfter(gridView.trailingAnchor, multiplier: 1)
        ]
        self.view.addConstraints(constraints)
    }
}
