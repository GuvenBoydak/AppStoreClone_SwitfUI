//
//  AppResponse.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 17.01.2024.
//

import Foundation



struct Apps: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let title: String
    let results: [AppResult]
}

struct AppResult: Codable {
    let artistName, id, name, releaseDate: String
    let artworkUrl100: String
    let genres: [Genre]
    let url: String
}

struct Genre: Codable {
    let genreID: String
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}
