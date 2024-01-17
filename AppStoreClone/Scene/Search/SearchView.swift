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
            ScrollView(.vertical){
                ForEach(searchVM.searchResponse,id:\.trackId) { data in
                    SearchCellView(data: data)
                }
            }
        }
        .searchable(text: $searchVM.keyword)
        .onChange(of: searchVM.keyword, { _, newValue in
            if !newValue.isEmpty{
                Task {
                    await searchVM.searchData()
                }
            }
        })
    }
}

#Preview {
    SearchView()
}

struct SearchCellView: View {
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
                    Text(data.primaryGenreName)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal)
                Spacer()
                Button("GET") {
                    
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            ScrollView(.horizontal) {
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

struct ImageView: View {
    var image: String = ""
    var body: some View {
        AsyncImage(url: URL(string: image)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .cornerRadius(10)
        } placeholder: {
            ProgressView()
        }
    }
}

