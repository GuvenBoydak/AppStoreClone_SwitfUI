//
//  SearchViewModel.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 17.01.2024.
//

import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var keyword: String = ""
    @Published var searchResponse: [SearchResult] = []
    
   private let networkManager: NetworkProtocol
    
    init( networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func searchData() async {
        let url = "\(Path.base_url.rawValue)\(Path.search.rawValue)\(String(describing: keyword.trimmingCharacters(in: .whitespacesAndNewlines)))\(Path.entity.rawValue)"
        do {
            let result: Search = try await networkManager.fetchRequest(path: url, method: .get)
            searchResponse = result.results
        } catch  {
            print(error)
        }
    }
}
