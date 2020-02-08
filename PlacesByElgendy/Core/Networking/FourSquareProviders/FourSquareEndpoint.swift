//
//  Endpoint.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

public protocol RequestProviding {
    var urlRequest: URLRequest { get }
}

public struct SearchVenusParameters {
    var latitude: Double
    var longitude: Double
    var near = "Istanbul"
    var intent = "match"
    var radius = "radius"
    var limit = 50
}

public enum FourSquareEndpoint: RequestProviding {
    
    case searchVenues(params: SearchVenusParameters)
    
    public var urlRequest: URLRequest {
        var urlComponents = URLComponents()
        urlComponents.host = AppConstants.FourSquare.host
        switch self {
        case .searchVenues:
            urlComponents.path = "venues/search"
            return URLRequest(url: urlComponents.url!)
        }
    }
    
}
