//
//  AppDetailViewModel.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 18.01.2024.
//

import Foundation

@MainActor
final class AppDetailViewModel: ObservableObject {
    @Published var appDetail: SearchResult?
    @Published var raitings: [Raiting] = []
    
    private let networkManager: NetworkProtocol
    
    init( networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func searchById(_ id: String) async {
        guard let newİd = Int(id) else { return }
        let url = "\(Path.base_url.rawValue)\(Path.lookup.rawValue)\(newİd)"
        do {
            let result: Search = try await networkManager.fetchRequest(path: url, method: .get)
            if !result.results.isEmpty {
                appDetail = result.results[0]
            }
        } catch  {
            print(error)
        }
    }
    
    func getRaitings(_ id: String) async {
        guard let newİd = Int(id) else { return }
        let url = "\(Path.base_url.rawValue)\(Path.raiting.rawValue)\(newİd)\(Path.raitingEnd.rawValue)"
        do {
            let result: RatingsResponse = try await networkManager.fetchRequest(path: url, method: .get)
            raitings = result.feed.entry
        } catch {
            print(error)
        }
    }
}
