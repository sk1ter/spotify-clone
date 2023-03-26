//
//  Playlist.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 26/03/23.
//

import Foundation


struct Playlist: Codable {
    let collaborative: Bool
        let description: String
        let externalUrls: ExternalUrls
        let followers: Followers
        let href, id: String
        let images: [Image]
        let name: String
        let owner: Owner
        let welcomePublic: Bool
        let snapshotID: String
        let tracks: Pagination<PlaylistItem>
        let type, uri: String

        enum CodingKeys: String, CodingKey {
            case collaborative, description
            case externalUrls = "external_urls"
            case followers, href, id, images, name, owner
            case welcomePublic = "public"
            case snapshotID = "snapshot_id"
            case tracks, type, uri
        }
}

struct PlaylistItem: Codable {
    let addedAt: Date
    let addedBy: Owner
    let isLocal: Bool
    let track: Track

    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case addedBy = "added_by"
        case isLocal = "is_local"
        case track
    }
}

struct Owner: Codable {
    let externalUrls: ExternalUrls
    let followers: Followers?
    let href, id, type, uri: String
    let displayName, name: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, href, id, type, uri
        case displayName = "display_name"
        case name
    }
}
