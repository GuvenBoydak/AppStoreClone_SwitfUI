//
//  AppCellView.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 18.01.2024.
//

import SwiftUI

struct AppCellView: View {
    var appcell: AppCell
    var body: some View {
        VStack {
            HStack {
                AppImageView(url: appcell.artworkUrl100)
                VStack(alignment: .leading) {
                    Text(appcell.name)
                        .font(.callout)
                        .frame(width: 120,alignment: .leading)
                        .foregroundColor(.black)
                    Text(appcell.genreName)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                Button(LocalizableKey.Apps.downland.rawValue.locale()) {
                    
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

#Preview {
    AppCellView(appcell: AppCell(name: "sada", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/c7/c0/1a/c7c01ade-8b83-b8ac-2cb8-fcccc9f9ba4c/TwitchAppIcon-0-1x_U007emarketing-0-7-0-0-85-220-0.png/100x100bb.jpg", genreName: "adasd"))
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
