//
//  GridBackedByTableViewController.swift
//  UILayoutGuideAndUIStackView
//
//  Created by Bart van Kuik on 31/07/2018.
//  Copyright © 2018 DutchVirtual. All rights reserved.
//


/*
 This code will crash with the following exception:
 
 *** Terminating app due to uncaught exception 'NSGenericException', reason: 'Unable to activate constraint with
 anchors <NSLayoutXAxisAnchor:0x600000462500 "UILabel:0x7f8c5450e870'Lorem, ipsum, dolor, sit,...'.right"> and
 <NSLayoutXAxisAnchor:0x600000462580 "UIView:0x7f8c59007340.left"> because they have no common ancestor.  Does the
 constraint or its anchors reference items in different view hierarchies?  That's illegal.'
 */

import UIKit

class GridTableViewCell: UITableViewCell {
    let label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.label)
        
        let constraints = [
            self.label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ]
        self.contentView.addConstraints(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GridBackedByTableViewController: UIViewController {
    private let tableView = UITableView()
    private let cellReuseIdentifier = "cell"
    private let columnLayoutGuide = UIView()
    
    override func viewDidLoad() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.dataSource = self
        self.tableView.register(GridTableViewCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
        self.view.addSubview(self.tableView)
        
        self.columnLayoutGuide.translatesAutoresizingMaskIntoConstraints = false
        self.columnLayoutGuide.backgroundColor = UIColor(displayP3Red: 0.3, green: 0, blue: 0, alpha: 0.5)
        self.tableView.addSubview(self.columnLayoutGuide)

        let guide = self.view.safeAreaLayoutGuide
        let constraints = [
            tableView.leadingAnchor.constraintEqualToSystemSpacingAfter(guide.leadingAnchor, multiplier: 1),
            tableView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1),
            guide.trailingAnchor.constraintEqualToSystemSpacingAfter(tableView.trailingAnchor, multiplier: 1),
            guide.bottomAnchor.constraintEqualToSystemSpacingBelow(tableView.bottomAnchor, multiplier: 1),
            
            self.columnLayoutGuide.topAnchor.constraint(equalTo: self.tableView.topAnchor),
            self.columnLayoutGuide.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor),
            self.columnLayoutGuide.rightAnchor.constraint(equalTo: self.tableView.rightAnchor),
            self.columnLayoutGuide.widthAnchor.constraint(equalTo: self.tableView.widthAnchor, multiplier: 0.5)
        ]
        self.view.addConstraints(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tabBarItem.title = "Grid Table View"
    }
}

extension GridBackedByTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as? GridTableViewCell else {
            fatalError()
        }
        cell.label.text = globalData[indexPath.row].joined(separator: ", ")
        cell.label.rightAnchor.constraint(equalTo: self.columnLayoutGuide.leftAnchor).isActive = true
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
