//
//  TodayView.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 18.01.2024.
//

import SwiftUI

struct TodayView: View {
    @StateObject var todayVM = TodayViewModel(networkManager: NetworkManager())
    @State private var isShow: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack{
                    ForEach(todayVM.result.prefix(3), id: \.trackId) { data in
                        ExtractedView(data: data)
                            .onTapGesture {
                                isShow.toggle()
                            }
                            .navigationDestination(isPresented: $isShow) {
                                TodayDetailView(data: data)
                                    .navigationBarBackButtonHidden()
                                    .ignoresSafeArea()
                            }
                    }
                }
                .task {
                    await todayVM.fetchData()
                }
            }
        }
    }
}

#Preview {
    TodayView()
}

private struct ExtractedView: View {
    var data: SearchResult
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.gray)
                .frame( height: 400)
                .opacity(0.2)
                .cornerRadius(15)
                .overlay(
                    VStack {
                        AsyncImage(url: URL(string: data.artworkUrl512)) { image in
                            image
                                .resizable()
                                .frame(height:300)
                                .cornerRadius(15)
                        } placeholder: {
                            ProgressView()
                        }
                        Spacer()
                        AppCellView(appcell: AppCell(name: data.trackName,
                                                     artworkUrl100: data.artworkUrl100,
                                                     genreName: data.primaryGenreName))
                        Spacer()
                    }
                )
        }
        .padding()
        .navigationTitle(LocalizableKey.Today.today.rawValue.locale())
    }
}
