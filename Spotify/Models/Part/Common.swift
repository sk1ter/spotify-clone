//
//  Common.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 26/03/23.
//

import Foundation

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String?
}

// MARK: - Copyright
struct Copyright: Codable {
    let text, type: String
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc, ean, upc: String
}

// MARK: - Image
struct Image: Codable {
    let url: String
    let height, width: Int
}

// MARK: - Restrictions
struct Restrictions: Codable {
    let reason: String
}

struct Followers: Codable {
    let href: String
    let total: Int
}
