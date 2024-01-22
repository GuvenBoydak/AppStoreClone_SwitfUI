//
//  RaitingResponse.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 19.01.2024.
//

import Foundation
struct RatingsResponse: Codable {
    let feed: RatingFeed
}
struct RatingFeed: Codable {
    let entry: [Raiting]
}
struct Raiting: Codable,Identifiable{
    var id = UUID().uuidString
    let author: Author
    let title: Label
    let content: Label
    let rating: Label
    private enum CodingKeys: String, CodingKey{
        case author
        case title
        case content
        case rating = "im:rating"
    }
}
struct Author: Codable {
    let name: Label
}
struct Label: Codable {
    let label: String
}
