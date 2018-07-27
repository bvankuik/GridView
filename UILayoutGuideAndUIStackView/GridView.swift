//
//  GridView.swift
//  UILayoutGuideAndUIStackView
//
//  Created by Bart van Kuik on 27/07/2018.
//  Copyright © 2018 DutchVirtual. All rights reserved.
//

import UIKit

class GridView: UIView {
    private let verticalStackView = UIStackView()
    private let columnLayoutGuides: [UIView] // later: [UILayoutGuide]
    private var nRows = 0
    private var horizontalViews: [UIView] = []
    
    func addRow(_ views: [UIView]) {
        guard views.count == (self.columnLayoutGuides.count + 1) else {
            fatalError("Number of views (\(views.count)) must be equal to number of columns plus 1 (\(self.columnLayoutGuides.count))")
        }
        
        let horizontalView = UIView()
        horizontalView.accessibilityIdentifier = "horizontalView_\(self.nRows)"
        self.horizontalViews.append(horizontalView)
        self.verticalStackView.addArrangedSubview(horizontalView)
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            horizontalView.addSubview($0)
        }
        
        var constraints: [NSLayoutConstraint] = []
        for i in 0 ..< views.count {
            let view = views[i]

            if i == 0 {
                // First column
                let layoutGuide = self.columnLayoutGuides[i]
                let nextView = views[i+1]
                constraints.append(contentsOf: [
                    view.leftAnchor.constraint(equalTo: horizontalView.leftAnchor),
                    view.rightAnchor.constraint(lessThanOrEqualTo: layoutGuide.leftAnchor),
                    nextView.leftAnchor.constraint(equalTo: layoutGuide.rightAnchor),
                    layoutGuide.widthAnchor.constraint(equalToConstant: 10)
                ])
            } else if i == (views.count - 1) {
                // Last column
                constraints.append(
                    view.rightAnchor.constraint(lessThanOrEqualTo: horizontalView.rightAnchor)
                )
            } else {
                // Middle column
                let layoutGuide = self.columnLayoutGuides[i]
                let nextView = views[i+1]
                constraints.append(contentsOf: [
                    layoutGuide.leftAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor),
                    layoutGuide.rightAnchor.constraint(equalTo: nextView.leftAnchor),
                    layoutGuide.widthAnchor.constraint(equalToConstant: 10)
                ])
            }
            constraints.append(contentsOf: [
                view.topAnchor.constraint(equalTo: horizontalView.topAnchor),
                view.bottomAnchor.constraint(equalTo: horizontalView.bottomAnchor)
            ])
        }
        
        self.addConstraints(constraints)
        self.nRows += 1
    }
    
    // MARK: - Life cycle
    
    init(columns: Int) {
        self.columnLayoutGuides = (0..<(columns-1)).map { _ in
//            let guide = UILayoutGuide()
            UIView()
        }
        super.init(frame: CGRect())
        
        self.verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.verticalStackView.axis = .vertical
        self.verticalStackView.alignment = .leading
        self.verticalStackView.spacing = 8
        self.addSubview(self.verticalStackView)
        
        let constraints = [
            self.verticalStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.verticalStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        self.addConstraints(constraints)
        
        var colNumber = 0
        self.columnLayoutGuides.forEach {
            $0.accessibilityIdentifier = "col_\(colNumber)"
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
            colNumber += 1
        }
        let columnLayoutGuideConstraints = self.columnLayoutGuides.flatMap {
            return [$0.topAnchor.constraint(equalTo: self.topAnchor),
                    $0.bottomAnchor.constraint(equalTo: self.bottomAnchor)]
        }
        self.addConstraints(columnLayoutGuideConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

