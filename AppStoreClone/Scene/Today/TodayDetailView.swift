//
//  TodayDetailView.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 18.01.2024.
//

import SwiftUI

struct TodayDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var data: SearchResult
    var body: some View {
        ScrollView(.vertical) {
            VStack{
                AsyncImage(url: URL(string: data.artworkUrl512)) { image in
                    ZStack {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height:350)
                            .overlay(
                                VStack {
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            presentationMode.wrappedValue.dismiss()
                                        }) {
                                            Image(systemName: ImageKey.Today.close.rawValue)
                                                .foregroundColor(.primary)
                                                .font(.title)
                                                .padding()
                                        }
                                    }
                                    .padding(.vertical,30)
                                    Spacer()
                                })
                    }
                } placeholder: {
                    ProgressView()
                }
                AppCellView(appcell: AppCell(name: data.trackName,
                                             artworkUrl100: data.artworkUrl100,
                                             genreName: data.primaryGenreName))
                .padding(.top,25)
                Text(data.description.trimSquareBrackets())
                    .padding()
                    .overlay {
                        Rectangle()
                            .stroke()
                            .background(Color.gray)
                            .opacity(0.1)
                    }
                Spacer()
            }
        }
    }
}

#Preview {
    TodayDetailView(data: SearchResult(primaryGenreName: "Games",
                                       artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/bf/eb/ca/bfebca26-3547-f8e9-f879-90a88c256bec/AppIcon-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-8.png/100x100bb.jpg",
                                       artworkUrl512: "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/bf/eb/ca/bfebca26-3547-f8e9-f879-90a88c256bec/AppIcon-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-8.png/512x512bb.jpg",
                                       trackName: "Pubg Mobile",
                                       screenshotUrls: [],
                                       description: "【Epic battle royale masterpiece】\nLots of events for you to explore.Climb to the top in PUBG MOBILE and fire at will. PUBG MOBILE is the original battle royale game on mobile and one of the best mobile shooting games.\n\n【Extreme battles in 10-minute matches】\nPrepare your firearms, respond to the call for battle in PUBG MOBILE, and fire at will.\n\n【Tons of maps and modes】\nPUBG MOBILE has many maps and gameplay mechanics that give you a thrilling survival experience. Find your friends and play the new modes together! Play however you like and fire at will!\n\n【Play anytime, anywhere】\nRelax and play PUBG MOBILE to your heart's content! Enjoy the smoothest gunplay for an unparalleled gameplay experience.\n\n【Made especially for mobile phones】\nFeatures customizable controls, training mode, and voice chat with friends. Experience the smoothest control experience and the most realistic firearms on your phone.\n\nPUBG MOBILE has the highest fidelity items and gameplay experience. PUBG MOBILE can fulfill any wish you might have. Choose from countless firearms and test your marksmanship. New items, maps, and modes are constantly being added to the game.\n\nPUBG MOBILE offers the most intense multiplayer battles on your mobile phone. Join the battle, gear up, and play to win. Survive in epic 100-player battles in Classic Mode, Payload , fast-paced 4v4 Arena battles, and Infection Mode. Survival is all that matters. Be the last one standing. Accept missions and fire at will!\n\n【Follow us】\nInstagram: https://www.instagram.com/pubgmobile\nFacebook: https://www.facebook.com/PUBGMOBILE\nTwitter: https://twitter.com/PUBGMobile\nYoutube: https://www.youtube.com/pubgmobile\nTiktok: https://www.tiktok.com/@pubgmobile\nReddit: https://www.reddit.com/r/PUBGMobile/\nDiscord: https://discord.gg/pubgm\nPlease contact customer service if you encounter any problems: service@pubgmobile.com\n\nPlease read PUBG MOBILE's Privacy Policy and User Agreement\nPrivacy Policy: http://pubgmobile.proximabeta.com/privacy.html\nTencent Games User Agreement: https://www.pubgmobile.com/terms.html",
                                       trackId: 123))
    .ignoresSafeArea()
}

