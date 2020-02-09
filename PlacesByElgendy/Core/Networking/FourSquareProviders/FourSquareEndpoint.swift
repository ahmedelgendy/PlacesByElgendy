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

public enum FourSquareEndpoint: RequestProviding {
    
    case searchVenues(params: SearchVenusParameters)
    case venueDetails(venueId: String)

    public var urlRequest: URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = AppConstants.FourSquare.scheme
        urlComponents.host = AppConstants.FourSquare.host
        urlComponents.addQuery(key: "client_id", value: AppConstants.FourSquare.clientId)
        urlComponents.addQuery(key: "client_secret", value: AppConstants.FourSquare.clientSecret)
        urlComponents.addQuery(key: "v", value: "20200201") // yyyyMMdd

        switch self {
        case .searchVenues(let params):
            urlComponents.path = "/v2/venues/explore"
            urlComponents.addQuery(key: "near", value: params.near)
            urlComponents.addQuery(key: "radius", value: "\(params.radius)")
            urlComponents.addQuery(key: "limit", value: "\(params.limit)")
            urlComponents.addQuery(key: "offset", value: "\(params.offset)")
            
        case .venueDetails(let venueId):
            urlComponents.path = "/v2/venues/\(venueId)"
        }
        
        return URLRequest(url: urlComponents.url!)
    }
    
}

extension URLComponents {
    mutating func addQuery(key: String, value: String) {
        if self.queryItems == nil {
            self.queryItems = [URLQueryItem]()
        }
        let param = URLQueryItem(name: key, value: value)
        self.queryItems?.append(param)
    }
}
