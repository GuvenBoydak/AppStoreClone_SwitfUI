//
//  AppHeaderResponse.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 17.01.2024.
//

import Foundation



struct AppHeader: Codable {
    let id, name, title: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, name, title
        case imageURL = "imageUrl"
    }
}
