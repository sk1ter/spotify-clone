//
//  Pagination.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 26/03/23.
//

import Foundation

struct Pagination<Item: Codable>: Codable {
    let href: String
    let limit: Int
    let next: String
    let offset: Int
    let previous: String
    let total: Int
    let items: [Item]
}
