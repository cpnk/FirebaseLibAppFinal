//
//  LoadingCell.swift
//  FirebaseLibApp
//
//  Created by Илья Валевич on 4/29/19.
//  Copyright © 2019 IlyaValevich. All rights reserved.
//

import Foundation
import UIKit

class LoadingCell: UITableViewCell {
    
    
    var spinner:UIActivityIndicatorView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        spinner = UIActivityIndicatorView(style: .gray)
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.topAnchor.constraint(equalTo: topAnchor, constant: 24.0).isActive = true
        spinner.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
