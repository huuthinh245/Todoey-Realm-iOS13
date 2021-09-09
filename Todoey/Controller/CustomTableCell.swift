//
//  CustomTableCell.swift
//  Todoey
//
//  Created by thinh on 12/9/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import UIKit

class CustomTableCell: UITableViewCell {
    var title: String?
    var date: Date?
    
    var titleLabel: UILabel = {
        var textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.accessoryView?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        self.accessoryView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.accessoryView?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let title =  title {
            titleLabel.text = title
        }
//        if let done = done  {
//            print(done)
//            self.accessoryType = done ? .checkmark : .none
//        }
    }
}
