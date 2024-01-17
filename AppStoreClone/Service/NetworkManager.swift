//
//  NetworkManager.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 17.01.2024.
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
    case entity = "&entity=software"
}


protocol NetworkProtocol {
    func fetchRequest<T: Codable>(path: String,method: HTTPMethod) async throws -> T
}

final class NetworkManager: NetworkProtocol {

    func fetchRequest<T: Codable>(path: String, method: HTTPMethod) async throws -> T  {
        guard let url = URL(string: "\(Path.base_url.rawValue)\(path)\(Path.entity.rawValue)") else {
            throw ErrorMessage.URLError
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let urlSession = URLSession.shared
        do {
            let (data,_) = try await urlSession.data(for: urlRequest)
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch  {
            print(error)
            throw ErrorMessage.DataParseErrror
        }
    }
}
