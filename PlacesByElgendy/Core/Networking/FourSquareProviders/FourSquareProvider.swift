//
//  TripSearchProvider.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

protocol FourSquareProviding {
    var network: Networking { get }
    func searchVenues(params: SearchVenusParameters, _ completion: @escaping (Result<SearchVenuesResponse, Error>) -> Void)
}

struct FourSquareProvider: FourSquareProviding {
    
    let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func searchVenues(params: SearchVenusParameters, _ completion: @escaping (Result<SearchVenuesResponse, Error>) -> Void) {
        let endpoint = FourSquareEndpoint.searchVenues(params: params)
        network.execute(endpoint, completion: completion)
    }
}
