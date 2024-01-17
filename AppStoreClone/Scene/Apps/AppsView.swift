//
//  AppsView.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 17.01.2024.
//

import SwiftUI

struct AppsView: View {
    let paidGrid: [GridItem] = [
        GridItem(.fixed(60),spacing: 15,alignment: nil),
        GridItem(.fixed(60),spacing: 15,alignment: nil),
        GridItem(.fixed(60),spacing: 15,alignment: nil)
    ]
    
    var body: some View {
            NavigationStack {
                Divider()
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack {
                                AppHeaderView()
                                AppHeaderView()
                                AppHeaderView()
                            }
                            .padding(.vertical)
                        }
                        Divider()
                            .padding(.horizontal)
                        Text("Populer Ucretli")
                            .bold()
                        ScrollView(.horizontal,showsIndicators: false){
                            LazyHGrid(rows: paidGrid) {
                                PaidAppView()
                                PaidAppView()
                                PaidAppView()
                            }
                        }
                        Divider()
                            .padding(.horizontal)
                        Text("Populer Ucretsiz")
                            .bold()
                        ScrollView(.horizontal,showsIndicators: false){
                            LazyHGrid(rows: paidGrid) {
                                PaidAppView()
                                PaidAppView()
                                PaidAppView()
                            }
                        }
                        
                    }
                    .padding(.horizontal)
                }
                .navigationTitle(LocalizableKey.Apps.apps.rawValue.locale())
            }
        }
    }

#Preview {
    AppsView()
}

private struct AppImageView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/b3/52/4b/b3524b04-69be-42a2-a756-da7d02dd5b25/AppIcon-0-0-1x_U007emarketing-0-10-0-0-85-220.png/100x100bb.png")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:50,height: 50)
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

private struct PaidAppView: View {
    var body: some View {
        VStack {
            HStack {
                AppImageView()
                VStack(alignment: .leading) {
                    Text("Name Basli")
                        .font(.title3)
                    Text("Alt baslik")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                Button("Downland") {
                    
                }
                .frame(width: 100)
                .buttonStyle(.bordered)
                .cornerRadius(20)
                .padding(.leading,80)
                
            }
        }
    }
}

private struct AppHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name app")
                .font(.title3)
            Text("Alt baslik")
                .font(.subheadline)
            Spacer()
            AsyncImage(url: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/98/d1/49/98d149b0-645a-7cf4-fb16-3948ff3dd471/AppIcon-1x_U007emarketing-0-10-0-85-220.png/100x100bb.png")) { image in
                image
                    .resizable()
                    .frame(width:350,height: 220)
                    .cornerRadius(10)
            } placeholder: {
                
            }
            
        }
    }
}
