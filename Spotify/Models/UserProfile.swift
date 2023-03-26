//
//  UserProfile.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 20/03/23.
//

import Foundation

struct UserProfile: Codable {
    let id: String
    let country: String
    let display_name: String
    let email: String?
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let followers: Followers?
    let product: String
    let images: [Userimage]
}

struct Userimage: Codable {
    let url: String
}
