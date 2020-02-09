//
//  PlaceDetailsViewController.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 8.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher

class PlaceDetailsViewController: UIViewController, AlertDisplayer {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    private var viewModel: PlaceDetailsViewModel
    
    init(viewModel: PlaceDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.kf.indicatorType = .activity
        imageView.kf.indicator?.startAnimatingView()

        viewModel.delegate = self
        viewModel.fetchPlaceDetails()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == view {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

// MARK: - UI Methods
extension PlaceDetailsViewController {

    func setImageView(with urlString: String) {
        imageView.kf.indicator?.stopAnimatingView()
        imageView.kf.setImage(with: URL(string: urlString), options: [.transition(.fade(0.5))])
    }
    
    func setupMap(lat: Double, lng: Double) {
        let annotation = createAnnotation(lat: lat, lng: lng)
        mapView.addAnnotation(annotation)
        setMapRegion(for: annotation.coordinate)
    }
    
    func createAnnotation(lat: Double, lng: Double) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        return annotation
    }
    
    func setMapRegion(for coordinate: CLLocationCoordinate2D, latitudinalMeters: Double = 1000, longitudinalMeters: Double = 1000) {
        let viewRegion = MKCoordinateRegion(center: coordinate,
                                            latitudinalMeters: latitudinalMeters,
                                            longitudinalMeters: longitudinalMeters)
        self.mapView.setRegion(viewRegion, animated: false)
    }
}

extension PlaceDetailsViewController: PlaceDetailsViewModelDelegate {
    
    func onFetchCompleted(latitude: Double, longitude: Double, imageUrl: String) {
        setImageView(with: imageUrl)
        setupMap(lat: latitude, lng: longitude)
    }
    
    func onFetchFailure(reason: String) {
        displayAlert(with: "Erro", message: reason)
    }
    
}
