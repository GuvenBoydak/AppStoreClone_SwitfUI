//
//  TodayViewModel.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 18.01.2024.
//

import Foundation

@MainActor
final class TodayViewModel: ObservableObject {
    @Published var result: [SearchResult] = []

    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchData() async {
        let url = "\(Path.base_url.rawValue)\(Path.search.rawValue)Pubg\(Path.entity.rawValue)"
        do {
            let response: Search = try await networkManager.fetchRequest(path: url , method: .get)
            result = response.results
        } catch  {
            print(error)
        }
    }
}
