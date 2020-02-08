//
//  SearchVenuesResponse.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 7.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation


// MARK: - SearchVenuesResponse
struct SearchVenuesResponse: Codable {
    let meta: Meta
    let response: Response
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let requestID: String?

    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
}

// MARK: - Response
struct Response: Codable {
    let suggestedFilters: SuggestedFilters?
    let geocode: Geocode?
    let headerLocation, headerFullLocation, headerLocationGranularity: String?
    let totalResults: Int
    let suggestedBounds: Bounds?
    let groups: [Group]?
}

// MARK: - Geocode
struct Geocode: Codable {
    let what, geocodeWhere: String?
    let center: Center?
    let displayString: String?
    let cc: String?
    let geometry: Geometry?
    let slug, longID: String?

    enum CodingKeys: String, CodingKey {
        case what
        case geocodeWhere = "where"
        case center, displayString, cc, geometry, slug
        case longID = "longId"
    }
}

// MARK: - Center
struct Center: Codable {
    let lat, lng: Double?
}

// MARK: - Geometry
struct Geometry: Codable {
    let bounds: Bounds?
}

// MARK: - Bounds
struct Bounds: Codable {
    let ne, sw: Center?
}

// MARK: - Group
struct Group: Codable {
    let type, name: String?
    let items: [GroupItem]?
}

// MARK: - GroupItem
struct GroupItem: Codable {
    let reasons: Reasons?
    let venue: Venue
    let referralID: String?

    enum CodingKeys: String, CodingKey {
        case reasons, venue
        case referralID = "referralId"
    }
}

// MARK: - Reasons
struct Reasons: Codable {
    let count: Int?
    let items: [ReasonsItem]?
}

// MARK: - ReasonsItem
struct ReasonsItem: Codable {
    let summary: String?
    let type: String?
    let reasonName: String?
}

// MARK: - Venue
struct Venue: Codable {
    let id, name: String?
    let location: Location?
    let categories: [Category]?
    let photos: Photos?
    let venuePage: VenuePage?
}

// MARK: - Category
struct Category: Codable {
    let id, name, pluralName, shortName: String?
    let icon: Icon?
    let primary: Bool?
}

// MARK: - Icon
struct Icon: Codable {
    let iconPrefix: String?
    let suffix: String?

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

// MARK: - Location
struct Location: Codable {
    let address: String?
    let lat, lng: Double?
    let labeledLatLngs: [LabeledLatLng]?
    let postalCode: String?
    let cc: String
    let city, state: String?
    let country: String?
    let formattedAddress: [String]?
    let crossStreet, neighborhood: String?
}

// MARK: - LabeledLatLng
struct LabeledLatLng: Codable {
    let label: String?
    let lat, lng: Double?
}


// MARK: - Photos
struct Photos: Codable {
    let count: Int?
    let groups: [String]?
}

// MARK: - VenuePage
struct VenuePage: Codable {
    let id: String?
}

// MARK: - SuggestedFilters
struct SuggestedFilters: Codable {
    let header: String?
    let filters: [Filter]?
}

// MARK: - Filter
struct Filter: Codable {
    let name, key: String?
}
