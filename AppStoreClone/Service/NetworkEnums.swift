//
//  NetworkEnums.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 18.01.2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum ErrorMessage: Error {
    case URLError
    case DataParseErrror
}

enum Path: String {
    case base_url = "https://itunes.apple.com/"
    case search = "search?term="
    case lookup = "lookup?id="
    case entity = "&entity=software"
    case free = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/25/apps.json"
    case paid = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/25/apps.json"
    case header = "https://raw.githubusercontent.com/hakkicansengonul/hakkicansengonul.github.io/main/appstore/header"
}
