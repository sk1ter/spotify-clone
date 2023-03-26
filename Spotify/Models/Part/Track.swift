//
//  Track.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 26/03/23.
//

import Foundation

struct Track: Codable {
    let artists: [Artist]
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let explicit: Bool
    let externalUrls: ExternalUrls?
    let href, id: String
    let isPlayable: Bool?
    let linkedFrom: LinkedFrom?
    let restrictions: Restrictions?
    let name: String
    let previewURL: String?
    let trackNumber: Int?
    let type, uri: String
    let isLocal: Bool?
}

struct LinkedFrom: Codable {
    let externalUrls: ExternalUrls
    let href, id: String
    let name: String?
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}
