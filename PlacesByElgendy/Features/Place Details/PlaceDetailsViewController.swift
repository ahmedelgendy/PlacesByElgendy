//
//  PlaceDetailsViewController.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 8.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit
import MapKit

class PlaceDetailsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == view {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
