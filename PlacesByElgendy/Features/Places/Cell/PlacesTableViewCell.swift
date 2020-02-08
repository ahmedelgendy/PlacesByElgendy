//
//  PlacesTableViewCell.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 7.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.hidesWhenStopped = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(with venue: Venue?) {
        if let venue = venue {
            placeNameLabel.text = venue.name
            addressLabel.text = venue.location?.neighborhood
            placeNameLabel.alpha = 1.0
            addressLabel.alpha = 1.0
            activityIndicator.stopAnimating()
        } else {
            placeNameLabel.alpha = 0
            addressLabel.alpha = 0
            activityIndicator.startAnimating()
        }
        
    }
    
}
