//
//  SearchView.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 17.01.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchVM = SearchViewModel(networkManager: NetworkManager())
    var body: some View {
        NavigationStack {
            ScrollView(.vertical,showsIndicators: false){
                  ForEach(searchVM.searchResponse,id:\.trackId) { data in
                      NavigationLink(destination: AppDetailView(id: String(data.trackId)).navigationBarTitleDisplayMode(.inline)) {
                 SearchCellView(data: data)
                         }
             }
            }
        }
        .searchable(text: $searchVM.keyword)
        .onChange(of: searchVM.keyword, { _, newValue in
            if !newValue.isEmpty {
                Task {
                    await searchVM.searchData()
                }
            }
            searchVM.searchResponse = []
        })
    }
}

#Preview {
    SearchView()
}

private struct SearchCellView: View {
    var data: SearchResult
    var body: some View {
        VStack{
            HStack{
                AsyncImage(url: URL(string: data.artworkUrl100)) { image in
                    image
                        .resizable()
                        .frame(width:60,height: 60)
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment:.leading) {
                    Text(data.trackName)
                        .font(.title3)
                        .lineLimit(1)
                    Text(data.primaryGenreName)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal)
                Spacer()
                Button(LocalizableKey.Apps.downland.rawValue.locale()) {
                    
                }
                .buttonStyle(.bordered)
            }
            .padding(.horizontal)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack{
                    ForEach(data.screenshotUrls,id:\.self) { image in
                        ImageView(image: image)
                    }
                }
                .padding()
            }
        }
    }
}

private struct ImageView: View {
    var image: String
    var body: some View {
        AsyncImage(url: URL(string: image)) { image in
            image
                .resizable()
                .frame(width: 100,height: 180)
                .cornerRadius(10)
        } placeholder: {
            ProgressView()
        }
    }
}

