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
    
    let networkManager: NetworkProtocol
    
    init( networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func searchData() async {
        do {
            let result: Search = try await networkManager.fetchRequest(path: "\(Path.search.rawValue)\(String(describing: keyword.trimmingCharacters(in: .whitespacesAndNewlines)))", method: .get)
            searchResponse = result.results
        } catch  {
            print(error)
        }
    }
}
