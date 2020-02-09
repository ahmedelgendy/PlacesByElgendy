//
//  PlaceDetailsViewModel.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 8.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

protocol PlaceDetailsViewModelDelegate: class {
    func onFetchCompleted(latitude: Double, longitude: Double, imageUrl: String)
    func onFetchFailure(reason: String)
}

class PlaceDetailsViewModel {
    
    weak var delegate: PlaceDetailsViewModelDelegate?
    
    private let placeId: String
    private let provider: FourSquareProvider
    
    private var imageURL: String?
    
    init(placeId: String, provider: FourSquareProvider) {
        self.placeId = placeId
        self.provider = provider
    }
    
    func fetchPlaceDetails() {
        provider.venueDetails(venueId: placeId) { result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    print(value)
                    if let venue = value.response?.venue {
                        let imageUrl = venue.photos?.groups?.first?.items?.first?.imageURL ?? ""
                        self.delegate?.onFetchCompleted(latitude: venue.location.lat,
                                                        longitude: venue.location.lng,
                                                        imageUrl: imageUrl)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error as Any)
                    self.delegate?.onFetchFailure(reason: error.localizedDescription)
                }
            }
        }
    }
    
}
