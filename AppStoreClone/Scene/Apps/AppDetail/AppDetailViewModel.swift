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
}
