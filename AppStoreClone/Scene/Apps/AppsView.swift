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
                                    TopAppView(topApp: app)
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
                                    TopAppView(topApp: app)
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

private struct AppImageView: View {
    var url: String
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:50,height: 50)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                        .stroke(lineWidth: 0.8)
                        .fill(.gray)
                        .shadow(radius: 10))
        } placeholder: {
            ProgressView()
        }
    }
}

private struct TopAppView: View {
    var topApp: AppResult
    var body: some View {
        VStack {
            HStack {
                AppImageView(url: topApp.artworkUrl100)
                VStack(alignment: .leading) {
                    Text(topApp.name)
                        .font(.callout)
                        .frame(width: 120,alignment: .leading)
                    Text(topApp.genres.isEmpty ? "" : topApp.genres[0].name)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                Button(LocalizableKey.Apps.dowland.rawValue.locale()) {
                    
                }
                .frame(width: 100)
                .buttonStyle(.bordered)
                .cornerRadius(20)
                .padding(.leading,60)
            }
            Divider()
                .padding(.horizontal,60)
        }
    }
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
