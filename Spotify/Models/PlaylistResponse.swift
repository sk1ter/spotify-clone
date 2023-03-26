//
//  PlaylistResponse.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 26/03/23.
//

import Foundation

struct PlaylistResponse: Codable {
    let message: String
    let playlists: Pagination<Playlist>
}
