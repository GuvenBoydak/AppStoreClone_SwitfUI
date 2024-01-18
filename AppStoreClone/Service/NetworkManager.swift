//
//  NetworkManager.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 17.01.2024.
//

import Foundation

protocol NetworkProtocol {
    func fetchRequest<T: Codable>(path: String,method: HTTPMethod) async throws -> T
}

final class NetworkManager: NetworkProtocol {

    func fetchRequest<T: Codable>(path: String, method: HTTPMethod) async throws -> T  {
        guard let url = URL(string: path) else {
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
