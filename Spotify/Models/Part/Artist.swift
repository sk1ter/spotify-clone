//
//  Artist.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 20/03/23.
//

import Foundation

struct Artist: Codable {
    let externalUrls: ExternalUrls
    let followers: Followers?
    let genres: [String]?
    let href, id: String
    let images: [Image]?
    let name: String?
    let popularity: Int?
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}
