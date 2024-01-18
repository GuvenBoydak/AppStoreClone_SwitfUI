//
//  TabbarView.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 17.01.2024.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            AppsView().tabItem {
                Image(systemName: ImageKey.Apps.app.rawValue)
                Text(LocalizableKey.Apps.apps.rawValue.locale())
            }
            SearchView()
                .tabItem {
                Image(systemName: ImageKey.Search.search.rawValue)
                Text(LocalizableKey.Search.search.rawValue.locale())
            }
            TodayView().tabItem {
                Image(systemName: ImageKey.Today.today.rawValue)
                Text(LocalizableKey.Today.today.rawValue.locale())
            }
        }
    }
}

#Preview {
    TabbarView()
}
