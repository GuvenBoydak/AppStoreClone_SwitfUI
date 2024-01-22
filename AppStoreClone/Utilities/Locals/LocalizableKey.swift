//
//  LocalizableKey.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 17.01.2024.
//

import Foundation
import SwiftUI

struct LocalizableKey {
    enum Apps: String {
        case apps = "Apps"
        case paid = "Popular paid"
        case free = "Popular free"
        case downland = "Downland"
        case preview = "Preview"
        case version = "Version"
        case whatsnew = "Whats New"
        case daybefore = "3 days before"
        case raiting = "Raiting and Comment"
    }
    
    enum Today: String {
        case today = "Today"
    }
    
    enum Search: String {
        case search = "Search"
    }
}
