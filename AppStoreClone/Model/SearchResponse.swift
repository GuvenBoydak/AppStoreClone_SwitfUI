//
//  SearchResponse.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 17.01.2024.
//

import Foundation

struct Search: Codable {
    let resultCount: Int
    let results: [SearchResult]
}
struct SearchResult: Codable {
    let primaryGenreName: String
    let artworkUrl100: String
    let artworkUrl512: String
    let trackName: String
    let screenshotUrls: [String]
    var averageUserRating: Float?
    var formattedPrice: String?
    let description: String
    let version: String
    var releaseNotes: String?
    let trackId: Int
}
