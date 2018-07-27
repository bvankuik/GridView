//
//  GridView.swift
//  UILayoutGuideAndUIStackView
//
//  Created by Bart van Kuik on 27/07/2018.
//  Copyright © 2018 DutchVirtual. All rights reserved.
//

import UIKit

// This class is meant for views to be properly laid out in a grid-like fashion. For growing vertically, a stackview is
// used. On the horizontal axis, a containerview is used. Each view in a row is spaced out with a UILayoutGuide.
class GridView: UIView {
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    private let verticalStackView = UIStackView()
    private let columnLayoutGuides: [UILayoutGuide]
    private var horizontalViews: [UIView] = []
    private var spacing: CGFloat = 8
    
    func addRow(_ views: [UIView]) {
        guard views.count == (self.columnLayoutGuides.count + 1) else {
            fatalError("Number of views (\(views.count)) must be equal to number of columns " +
                "plus 1 (\(self.columnLayoutGuides.count))")
        }
        
        let horizontalView = UIView()
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
                    layoutGuide.widthAnchor.constraint(equalToConstant: self.spacing)
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
                    layoutGuide.widthAnchor.constraint(equalToConstant: self.spacing)
                ])
            }
            constraints.append(contentsOf: [
                view.topAnchor.constraint(equalTo: horizontalView.topAnchor),
                view.bottomAnchor.constraint(equalTo: horizontalView.bottomAnchor)
            ])
        }
        
        self.addConstraints(constraints)
    }
    
    init(columns: Int) {
        self.columnLayoutGuides = (0 ..< columns-1).map { _ in
            UILayoutGuide()
        }
        super.init(frame: CGRect())
        
        self.verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.verticalStackView.axis = .vertical
        self.verticalStackView.alignment = .leading
        self.verticalStackView.spacing = self.spacing
        self.addSubview(self.verticalStackView)
        
        let constraints = [
            self.verticalStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.verticalStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        self.addConstraints(constraints)
        
        self.columnLayoutGuides.forEach {
            self.addLayoutGuide($0)
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

