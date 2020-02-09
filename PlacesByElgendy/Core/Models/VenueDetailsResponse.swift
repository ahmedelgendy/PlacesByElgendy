//
//  File.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 8.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

// MARK: - VenueDetailsResponse
struct VenueDetailsResponse: Codable {
    let meta: Meta?
    let response: VenueDetailsData?
}

// MARK: - Response
struct VenueDetailsData: Codable {
    let venue: VenueDetails?
}

// MARK: - Venue
struct VenueDetails: Codable {
    let id, name: String?
    let contact: Contact?
    let location: VenueDetailsLocation
    let canonicalURL: String?
    let categories: [VenueDetailsCategory]?
    let verified: Bool?
    let stats: Stats?
    let url: String?
    let likes: HereNow?
    let dislike, ok: Bool?
    let rating: Double?
    let ratingColor: String?
    let ratingSignals: Int?
    let allowMenuURLEdit: Bool?
    let beenHere: BeenHere?
    let specials: Inbox?
    let photos: Listed?
    let reasons: Inbox?
    let hereNow: HereNow?
    let createdAt: Int?
    let tips: Listed?
    let shortURL: String?
    let timeZone: String?
    let listed: Listed?
    let pageUpdates, inbox: Inbox?
    let attributes: Attributes?
    let bestPhoto: BestPhotoClass?

    enum CodingKeys: String, CodingKey {
        case id, name, contact, location
        case canonicalURL = "canonicalUrl"
        case categories, verified, stats, url, likes, dislike, ok, rating, ratingColor, ratingSignals
        case allowMenuURLEdit = "allowMenuUrlEdit"
        case beenHere, specials, photos, reasons, hereNow, createdAt, tips
        case shortURL = "shortUrl"
        case timeZone, listed, pageUpdates, inbox, attributes, bestPhoto
    }
}

// MARK: - Attributes
struct Attributes: Codable {
    let groups: [AttributesGroup]?
}

// MARK: - AttributesGroup
struct AttributesGroup: Codable {
    let type, name, summary: String?
    let count: Int?
    let items: [PurpleItem]?
}

// MARK: - PurpleItem
struct PurpleItem: Codable {
    let displayName, displayValue: String?
}

// MARK: - BeenHere
struct BeenHere: Codable {
    let count, unconfirmedCount: Int?
    let marked: Bool?
    let lastCheckinExpiredAt: Int?
}

// MARK: - BestPhotoClass
struct BestPhotoClass: Codable {
    let id: String?
    let createdAt: Int?
    let source: Source?
    let photoPrefix: String?
    let suffix: String?
    let width, height: Int?
    let visibility: String?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id, createdAt, source
        case photoPrefix = "prefix"
        case suffix, width, height, visibility, user
    }
}

// MARK: - Source
struct Source: Codable {
    let name: String?
    let url: String?
}

// MARK: - User
struct User: Codable {
    let id, firstName, lastName: String?
    let photo: IconClass?
}

// MARK: - IconClass
struct IconClass: Codable {
    let photoPrefix: String?
    let suffix: String?

    enum CodingKeys: String, CodingKey {
        case photoPrefix = "prefix"
        case suffix
    }
}

// MARK: - Category
struct VenueDetailsCategory: Codable {
    let id, name, pluralName, shortName: String?
    let icon: IconClass?
    let primary: Bool?
}

// MARK: - Contact
struct Contact: Codable {
    let phone, formattedPhone, instagram: String?
}

// MARK: - HereNow
struct HereNow: Codable {
    let count: Int?
    let summary: String?
    let groups: [HereNowGroup]?
}

// MARK: - Listed
struct Listed: Codable {
    let count: Int?
    let groups: [HereNowGroup]?
}

// MARK: - FluffyItem
struct FluffyItem: Codable {
    let id, name, itemDescription, type: String?
    let user: User?
    let editable, itemPublic, collaborative: Bool?
    let url: String?
    let canonicalURL: String?
    let createdAt, updatedAt: Int?
    let photo: BestPhotoClass?
    let followers: Followers?
    let listItems: Inbox?
    let source: Source?
    let itemPrefix: String?
    let suffix: String?
    let width, height: Int?
    let visibility, text, lang: String?
    let likes: Listed?
    let logView: Bool?
    let agreeCount, disagreeCount: Int?
    let todo: Followers?

    var imageURL: String {
        return (itemPrefix ?? "") + "500x300" + (suffix ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case itemDescription = "description"
        case type, user, editable
        case itemPublic = "public"
        case collaborative, url
        case canonicalURL = "canonicalUrl"
        case createdAt, updatedAt, photo, followers, listItems, source
        case itemPrefix = "prefix"
        case suffix, width, height, visibility, text, lang, likes, logView, agreeCount, disagreeCount, todo
    }
}

// MARK: - HereNowGroup
struct HereNowGroup: Codable {
    let type: String?
    let count: Int?
    let items: [FluffyItem]?
    let name: String?
}

// MARK: - Followers
struct Followers: Codable {
    let count: Int?
}

// MARK: - Inbox
struct Inbox: Codable {
    let count: Int?
    let items: [InboxItem]?
}

// MARK: - InboxItem
struct InboxItem: Codable {
    let id: String?
    let createdAt: Int?
    let summary, type, reasonName: String?
}

// MARK: - Location
struct VenueDetailsLocation: Codable {
    let address: String?
    let lat, lng: Double
    let labeledLatLngs: [LabeledLatLng]?
    let postalCode, cc, city, state: String?
    let country: String?
    let formattedAddress: [String]?
}

// MARK: - Stats
struct Stats: Codable {
    let tipCount: Int?
}
