//
//  GridBackedByTableViewController.swift
//  UILayoutGuideAndUIStackView
//
//  Created by Bart van Kuik on 31/07/2018.
//  Copyright © 2018 DutchVirtual. All rights reserved.
//

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
    
    override func viewDidLoad() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.dataSource = self
        self.tableView.register(GridTableViewCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
        self.view.addSubview(self.tableView)

        let guide = self.view.safeAreaLayoutGuide
        let constraints = [
            tableView.leadingAnchor.constraintEqualToSystemSpacingAfter(guide.leadingAnchor, multiplier: 1),
            tableView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1),
            guide.trailingAnchor.constraintEqualToSystemSpacingAfter(tableView.trailingAnchor, multiplier: 1),
            guide.bottomAnchor.constraintEqualToSystemSpacingBelow(tableView.bottomAnchor, multiplier: 1)
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
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
