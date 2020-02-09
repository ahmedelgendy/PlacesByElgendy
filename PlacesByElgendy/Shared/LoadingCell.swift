//
//  LoadingCell.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 9.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

class LoadingCell : UITableViewCell {
    
    var activityIndicator: UIActivityIndicatorView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    private func setupSubviews() {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .gray
        indicator.hidesWhenStopped = true
        
        contentView.addSubview(indicator)
        
        setupConstraints(indicator)
        indicator.startAnimating()
    }
    
    fileprivate func setupConstraints(_ indicator: UIActivityIndicatorView) {
        let topConstraint = NSLayoutConstraint(item: indicator, attribute: .top,  relatedBy: .equal, toItem: contentView, attribute:.top, multiplier: 1, constant: 10)
        
        let bottomConstraint = NSLayoutConstraint(item: indicator, attribute: .bottom,  relatedBy: .equal, toItem: contentView, attribute:.bottom, multiplier: 1, constant: -10)
        
        let centerConstraint = NSLayoutConstraint(item: indicator, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0)

        topConstraint.isActive = true
        bottomConstraint.isActive = true
        centerConstraint.isActive = true
    }
    
}
