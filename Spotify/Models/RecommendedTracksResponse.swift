//
//  RecommendedTracksResponse.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 26/03/23.
//

import Foundation

struct RecommendedTracksResponse: Codable {
    let seeds: [Seed]
    let tracks: [Track]
}

// MARK: - Seed

struct Seed: Codable {
    let afterFilteringSize, afterRelinkingSize: Int?
    let href, id: String?
    let initialPoolSize: Int?
    let type: String
}
