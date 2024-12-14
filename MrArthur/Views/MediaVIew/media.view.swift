//
//  media.view.swift
//  MrArthur
//
//  Created by IPS-157 on 04/08/22.
//

import SwiftUI

struct MediaView: View {
    @StateObject private var observed = MediaViewObserver()
    
    let onPlay: (MediaDetails?) -> ()
    
    var body: some View {
        NavigationView{
            Group {
                if observed.arrOfVideoCategoryWise.count > 0 {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 25) {
                            MediaListFeaturedView(
                                arrOfVideoCategoryWise: observed.arrOfVideoCategoryWise,
                                onPlay: onPlay
                            )
                            ForEach(observed.arrOfVideoCategoryWise ,id: \.catName){ catwisevideo in
                                MediaListSectionView(
                                    categoryName: catwisevideo.catName,
                                    arrOfVideo: catwisevideo.video,
                                    onPlay: onPlay
                                )
                            }
                        }
                        .padding(.top)
                    }
                } else {
                    ListEmptyView(message: "No media available here.")
                }
            }
            .hideNavigation
            .customNavigationView(
                title: "Medias".localized,
                color: .white
            )
            .background(
                LinearGradient(
                    colors: [
                        Color.lightPink,
                        Color.secondaryRed
                    ],
                    startPoint: .top,
                    endPoint: .bottomTrailing
                )
            )
        }
        .navigationViewStyle(.stack)
        .edgesIgnoringSafeArea(.bottom)
        
    }
}
