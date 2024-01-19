//
//  AppsView.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 17.01.2024.
//

import SwiftUI

struct AppsView: View {
    @StateObject var appsVM = AppsViewModel(networkMnager: NetworkManager())
    
    let paidGrid: [GridItem] = [
        GridItem(.fixed(60),spacing: 0,alignment: .leading),
        GridItem(.fixed(60),spacing: 0,alignment: .leading),
        GridItem(.fixed(60),spacing: 0,alignment: .leading)
    ]
    
    var body: some View {
            NavigationStack {
                Divider()
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack {
                                ForEach(appsVM.headerApps,id:\.id) { app in
                                    AppHeaderView(headerApp: app)
                                }
                            }
                            .padding(.vertical)
                        }
                        Divider()
                            .padding(.horizontal)
                        Text(LocalizableKey.Apps.paid.rawValue.locale())
                            .bold()
                        ScrollView(.horizontal,showsIndicators: false){
                            LazyHGrid(rows: paidGrid) {
                                ForEach(appsVM.topPaidApps,id:\.id) { app in
                                    NavigationLink(destination: AppDetailView(id: app.id).navigationBarTitleDisplayMode(.inline)) {
                                                AppCellView(appcell: AppCell(name: app.name,
                                                                              artworkUrl100: app.artworkUrl100,
                                                                              genreName: app.genres.isEmpty ? "" : app.genres[0].name))
                                            }
                                }
                            }
                        }
                        Divider()
                            .padding(.horizontal)
                        Text(LocalizableKey.Apps.free.rawValue.locale())
                            .bold()
                        ScrollView(.horizontal,showsIndicators: false){
                            LazyHGrid(rows: paidGrid) {
                                ForEach(appsVM.topFreeApps,id:\.id) { app in
                                    NavigationLink(destination: AppDetailView(id: app.id).navigationBarTitleDisplayMode(.inline)) {
                                                AppCellView(appcell: AppCell(name: app.name,
                                                                              artworkUrl100: app.artworkUrl100,
                                                                              genreName: app.genres.isEmpty ? "" : app.genres[0].name))
                                            }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle(LocalizableKey.Apps.apps.rawValue.locale())
            }
            .task {
                await appsVM.fetchTopPaid()
                await appsVM.fetchTopFree()
                await appsVM.fetchHeaderApp()
            }
        }
    }

#Preview {
    AppsView()
}



private struct AppHeaderView: View {
    var headerApp: AppHeader
    var body: some View {
        VStack(alignment: .leading) {
            Text(headerApp.name)
                .font(.title3)
            Text(headerApp.title)
                .font(.subheadline)
            Spacer()
            AsyncImage(url: URL(string: headerApp.imageURL)) { image in
                image
                    .resizable()
                    .frame(width:350,height: 220)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
        }
    }
}
