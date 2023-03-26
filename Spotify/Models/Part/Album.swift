//
//  Album.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 26/03/23.
//

import Foundation

struct Album: Codable {
    let albumType: String
    let totalTracks: Int
    let availableMarkets: [String]
    let externalUrls: ExternalUrls
    let href, id: String
    let images: [Image]
    let name, releaseDate, releaseDatePrecision: String
    let restrictions: Restrictions
    let type, uri: String
    let copyrights: [Copyright]
    let externalIDS: ExternalIDS
    let genres: [String]
    let label: String
    let popularity: Int
    let artists: [Artist]
    let tracks: Pagination<Track>

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case restrictions, type, uri, copyrights
        case externalIDS = "external_ids"
        case genres, label, popularity, artists, tracks
    }
}
