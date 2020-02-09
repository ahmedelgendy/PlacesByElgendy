//
//  PlacesViewModel.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 7.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

protocol PlacesViewModelDelegate: class {
  func onFetchCompleted(shouldShowLoadingCell: Bool)
  func onFetchFailed(with reason: String)
}

class PlacesViewModel {
    
    weak var delegate: PlacesViewModelDelegate?
    private var city: String
    private var provider: FourSquareProviding
    var onVenuesLoaded: (() -> Void)?
    
    private var searchParameters: SearchVenusParameters
    private var isFetchInProgress = false
    
    var itemOffset = 0
    
    private var venues = [GroupItem]()
    
    init(city: String, provider: FourSquareProviding) {
        self.city = city
        self.provider = provider
        searchParameters = SearchVenusParameters()
        searchParameters.near = city
    }
    
    func fetchPlaces() {
        guard !isFetchInProgress else {  return }
        isFetchInProgress = true
        provider.searchVenues(params: searchParameters) { (result) in
            switch result {
            case .success(let value):
                self.handleFetchPlacesSuccess(value)
            case .failure(let error):
                self.handleFetchPlacesFailure(error)
            }
        }
    }
    
    fileprivate func handleFetchPlacesSuccess(_ value: (SearchVenuesResponse)) {
        DispatchQueue.main.async {
            if let newVenues = value.response.groups?.first?.items {
                print("venues: ", newVenues.count)
                print("total: ", value.response.totalResults)
                self.venues.append(contentsOf: newVenues)
                self.searchParameters.offset += newVenues.count
                
                self.isFetchInProgress = false
                if self.searchParameters.offset < value.response.totalResults {
                    self.delegate?.onFetchCompleted(shouldShowLoadingCell: true)
                } else {
                    self.delegate?.onFetchCompleted(shouldShowLoadingCell: false)
                }
            }
        }
    }
    
    fileprivate func handleFetchPlacesFailure(_ error: (Error)) {
        DispatchQueue.main.async {
            self.isFetchInProgress = false
            print("venues error: ", error)
            self.delegate?.onFetchFailed(with: error.localizedDescription)
        }
    }
    
}

// MARK: - TableView DataSource
extension PlacesViewModel {
    
    func numberOfItems() -> Int {
        return venues.count
    }
    
    func venue(at index: Int) -> Venue {
        return venues[index].venue
    }
}

