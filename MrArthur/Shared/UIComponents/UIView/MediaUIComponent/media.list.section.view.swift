//
//  media.list.section.view.swift
//  MrArthur
//
//  Created by Troo on 05/09/22.
//

import SwiftUI

struct MediaListSectionView: View {
    var categoryName: String
    var arrOfVideo: [YoutubeMedia]
    
    let onPlay: (MediaDetails?) -> ()
   
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(categoryName)
                .fontModifier(
                    font: .montserratBlack,
                    size: iPhoneFont15,
                    color: .primaryBlue
                )
                .padding(.leading, .dynamicValue(
                    foriPhone: 16,
                    foriPad: 32
                ))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(arrOfVideo,id: \.ytVideoId) { tubeMedia in
                        
                        MediaListCellView(
                            media: tubeMedia ,
                            video: MediaDetails(
                                id: "",
                                thumbnail: "",
                                duration: 0,
                                title: tubeMedia.ytTitle,
                                category: tubeMedia.ytCategoryList.first,
                                createdAt: tubeMedia.ytCreatedAt  ,
                                description: tubeMedia.ytDescription,
                                url: "",
                                videoId: tubeMedia.ytVideoId,
                                src: "",
                                jsonUrl: "",
                                lang: "",
                                autoPlay: false,
                                mute: 5,
                                previewData: MediaPreviewData(
                                    title: "",
                                    subtitle: "",
                                    image: ""
                                ),
                                providerType: EVideoMediaProviderType.YOUTUBE
                            ),
                            onPlay: onPlay
                        )
                        .shadow(radius: 6, x: 0, y: 3)
                    }
                   
                }
                .padding([.bottom, .leading], .dynamicValue(
                    foriPhone: 16,
                    foriPad: 32
                ))
            }
        }
        
    }
}

/*
struct MedialistSectionView_Previews: PreviewProvider {
    static var previews: some View {
        MediaListSectionView(
            categoryName: "CAT", arrOfVideo: [], onPlay: {_ in}
        )
    }
}*/
