//
//  AppDetailView.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 18.01.2024.
//

import SwiftUI

struct AppDetailView: View {
    @StateObject var appDetailVM = AppDetailViewModel(networkManager: NetworkManager())
    var id: String
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack {
                AppHeaderView(appHeader: AppHeaderModel(url: appDetailVM.appDetail?.artworkUrl100 ?? "",
                                                        genreName: appDetailVM.appDetail?.primaryGenreName ?? "",
                                                        trackName: appDetailVM.appDetail?.trackName ?? ""))
                Divider()
                    .padding(.top)
                WhatsNewView(appDetail: WhatsNew(description: appDetailVM.appDetail?.description ?? "",
                                                 version: appDetailVM.appDetail?.version ?? ""))
                HStack {
                    Text(LocalizableKey.Apps.preview.rawValue.locale())
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                ScrollView(.horizontal,showsIndicators: false) {
                    LazyHStack( content: {
                        ForEach(appDetailVM.appDetail?.screenshotUrls ?? [],id: \.self){ detail in
                            ScreenShotView(url: detail)
                        }
                    })
                }
                Divider()
                HStack {
                    Text(LocalizableKey.Apps.raiting.rawValue.locale())
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                ScrollView(.horizontal,showsIndicators: false){
                    LazyHStack( content: {
                        ForEach(appDetailVM.raitings,id: \.id){ raiting in
                           RaitingView(raiting: raiting)
                        }
                    })
                    .task {
                        await appDetailVM.getRaitings(id)
                    }
                }
            }.padding()
            .task {
                await appDetailVM.searchById(id)
            }
        }
    }
}

#Preview {
    AppDetailView(id: "932747118")
}

private struct WhatsNew {
    let description: String
    let version: String
}
// MARK: WhatsNewView
private struct WhatsNewView: View {
    @State private var isExpanded = false
    var appDetail: WhatsNew
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(LocalizableKey.Apps.whatsnew.rawValue.locale())
                        .font(.title2)
                        .bold()
                    HStack {
                        Text(LocalizableKey.Apps.version.rawValue.locale())
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Text("\(appDetail.version)")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                Spacer()
                Text(LocalizableKey.Apps.daybefore.rawValue.locale())
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            VStack {
                if isExpanded {
                    Text(appDetail.description)
                        .font(.subheadline)
                        .padding(.top,4)
                }
                Text(appDetail.description)
                    .font(.subheadline)
                    .lineLimit(4)
                    .padding(.top,4)
            }
            .onTapGesture {
                isExpanded.toggle()
            }
            Divider()
        }
    }
}
// MARK: ScreenShotView
private struct ScreenShotView: View {
    var url: String
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:200,height: 355)
                .cornerRadius(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 1)
                }
        } placeholder: {
            ProgressView()
        }
    }
}

private struct AppHeaderModel {
    let url: String
    let genreName: String
    let trackName: String
}
// MARK: AppHeaderView
private struct AppHeaderView: View {
    var appHeader: AppHeaderModel
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: appHeader.url)) { image in
                image
                    .resizable()
                    .frame(width:120,height: 130)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 1)
                    }
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text(appHeader.trackName)
                    .font(.title)
                    .lineLimit(2)
                Text(appHeader.genreName)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Button(LocalizableKey.Apps.downland.rawValue.locale()) {
                }
                .buttonStyle(.borderedProminent)
                .cornerRadius(20)
            }
            Spacer()
        }
    }
}
// MARK: RaitingView
private struct RaitingView: View {
    var raiting: Raiting
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: 320,height: 200)
            .opacity(0.1)
            .overlay {
                VStack(alignment: .leading) {
                    HStack {
                        Text(raiting.title.label)
                            .font(.title3)
                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                            .bold()
                        Spacer()
                        Text(raiting.author.name.label)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    HStack {
                        ForEach(0...4,id:\.self) { value in
                            Image(systemName: value < Int(raiting.rating.label) ?? 0 ? ImageKey.Apps.starFill.rawValue : ImageKey.Apps.star.rawValue)
                                .resizable()
                                .foregroundColor(.yellow)
                                .font(.title)
                                .frame(width: 15,height: 15)
                        }
                    }
                    Text(raiting.content.label)
                        .font(.subheadline)
                        .lineLimit(6)
                        .padding(.top)
                    Spacer()
                }
                .padding()
            }
    }
}
