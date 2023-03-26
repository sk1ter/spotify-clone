//
//  NewReleasesResponse.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 26/03/23.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: Pagination<Album>
}
