//
//  DynamicTextCollectionViewCell.swift
//  CollectionViewSelfSizingCells
//
//  Created by Bart van Kuik on 19/03/2018.
//  Copyright © 2018 DutchVirtual. All rights reserved.
//

import UIKit

class DynamicTextCollectionViewCell: UICollectionViewCell {
    private let label = UILabel()
    var text: String? {
        get {
            return self.label.text
        }
        set {
            self.label.text = newValue
        }
    }
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.label.backgroundColor = .black
        self.label.textColor = .white
        self.label.font = .preferredFont(forTextStyle: .body)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.label)
        
        let constraints = [
            self.label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
        self.contentView.addConstraints(constraints)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil, queue: OperationQueue.main) { [weak self] notification in
            self?.label.font = UIFont.preferredFont(forTextStyle: .body)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
