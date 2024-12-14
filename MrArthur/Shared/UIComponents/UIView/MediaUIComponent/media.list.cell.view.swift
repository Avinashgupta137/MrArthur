//
//  media.list.cell.view.swift
//  MrArthur
//
//  Created by Troo on 05/09/22.
//

import SwiftUI

struct MediaListCellView: View {
    let media: YoutubeMedia
    let video: MediaDetails?
    @State var mediaYear: String = "YYYY"
    @StateObject var observed = MediaListCellObserved()
    @State var videoDetails: MediaDetails = MediaDetails()
    let onPlay: (MediaDetails?) -> ()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                ZStack {
                    AsyncImage(url: URL.init(string: "https://img.youtube.com/vi/\(media.ytVideoId)/maxresdefault.jpg")) { phase in
                        let height = 111.h
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(height: height)
                        } else if phase.error != nil {
                            Color.primaryYellow
                                .frame(height: height)
                        } else {
                            Color.primaryRed
                                .frame(height: height)
                        }
                    }
                    
                    Button {
                        AmplitudeService.sendEvent(
                            key: .ATT_MEDIAS_MAIN_LIBRARY_2_PLAY
                        )
                        onPlay(video)
                    } label: {
                        Image("MediasPlayer")
                            .resizable()
                            .frame(
                                width: .dynamicValue(
                                    foriPhone: 40,
                                    foriPad: 60
                                ),
                                height: .dynamicValue(
                                    foriPhone: 40,
                                    foriPad: 60
                                )
                            )
                    }
                    
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text(media.ytTitle)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont12,
                            color: .primaryBlue
                        )
                    
                    HStack(spacing: 0) {
                        Text(media.ytTitle)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont12,
                                color: .primaryBlue
                            )
                        Spacer(minLength: 16.w)
                        Text(mediaYear)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont12,
                                color: .primaryBlue
                            )
                    }
                    .padding(.vertical, 5.h)
                    
                    Rectangle()
                        .fill(Color.primaryBlue)
                        .frame(height: 1.h)
                        .padding(.vertical, 5.h)
                    
                    Text(media.ytDescription)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont12,
                            color: .primaryBlue
                        )
                        .lineLimit(4)
                    
                    Spacer(minLength: 8.h)
                    
                    Button {
                        if let id = video?.videoId {
                            observed.shareMedia(id)
                            AmplitudeService.sendEvent(
                                key: .ATT_MEDIAS_MAIN_LIBRARY_2_SHARE
                            )
                        }
                    } label: {
                        Image("buttonShare")
                            .resizable()
                            .frame(
                                width: 40.r,
                                height: 40.r
                            )
                            .shadow(radius: 6, x: 0, y: 3)
                    }
                    .contentShape(Rectangle())
                }
                .padding(.horizontal, 12.w)
                .padding(.vertical, 12.h)
            }
            Text(observed.getDurationOfVideo(video: media))
                .fontModifier(
                    font: .montserratBold,
                    size: iPhoneFont12
                )
                .padding(.vertical, 3.h)
                .padding(.horizontal, 8.w)
                .background(
                    Color.primaryRed
                        .cornerRadius(24.r)
                )
                .padding([.top, .trailing], 8.r)
        }
        .frame(
            width: 184.w,
            height: 300.h
        )
        .background(Color.white)
        .cornerRadius(24.r)
        .onAppear {
            setData()
        }
        
    }
    
    private func setData() {
        if let strDate = media.createdAt, strDate != "" {
            self.mediaYear = DateService.shared
                .getYearFromDateString(
                    dateString: strDate
                ) ?? "YYYY"
        }
    }
}

