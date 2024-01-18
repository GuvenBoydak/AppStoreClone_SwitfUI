//
//  AppsViewModel.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 17.01.2024.
//

import Foundation


@MainActor
final class AppsViewModel: ObservableObject {
    @Published var topPaidApps: [AppResult] = []
    @Published var topFreeApps: [AppResult] = []
    @Published var headerApps: [AppHeader] = []
    
    private let networkMnager: NetworkProtocol
    
    init(networkMnager: NetworkProtocol) {
        self.networkMnager = networkMnager
    }
    
    func fetchTopPaid() async {
        do {
            let result: Apps = try await networkMnager.fetchRequest(path: Path.paid.rawValue, method: .get)
            topPaidApps = result.feed.results
        } catch  {
            print(error)
        }
    }
    
    func fetchTopFree() async {
        do {
            let result: Apps = try await networkMnager.fetchRequest(path: Path.free.rawValue, method: .get)
            topFreeApps = result.feed.results
        } catch  {
            print(error)
        }
    }
    
    func fetchHeaderApp() async {
        do {
            let result: [AppHeader] = try await networkMnager.fetchRequest(path: Path.header.rawValue, method: .get)
            headerApps = result
        } catch  {
            print(error)
        }
    }
}
