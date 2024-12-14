//
//  media.list.featured.view.swift
//  MrArthur
//
//  Created by Troo on 05/09/22.
//

import SwiftUI

struct MediaListFeaturedView: View {
    var arrOfVideoCategoryWise:[VideoCategoryWiseModel] = [VideoCategoryWiseModel]()
    let onPlay: (MediaDetails?) -> ()
    
    var body: some View {
        let arrOfNewsVideo = arrOfVideoCategoryWise.filter{$0.catName.isEqualToString(find: "NEWS")}
        return VStack(spacing: 0) {
            HStack(spacing: 0){
                VStack(alignment: .leading) {
                    Text("Featured ".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25,
                            color: .primaryRed
                        )
                    Text("this month".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    Text("Enjoy the smart media content of the month! It won’t cost you any entertainment time credit!".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                }
                
                Spacer(minLength: 16.w)
                Image("MediasRobotSunPower")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 138.w,
                        height: 152.h
                    )
                
            }
            .padding(.vertical, 16.h)
            .padding(.horizontal, 24.w)
            
            ForEach(arrOfNewsVideo,id: \.catName) { catwisevideo in
                MediaListSectionView(
                    categoryName: catwisevideo.catName,
                    arrOfVideo: catwisevideo.video,
                    onPlay: onPlay
                )
            }
        }
        
        .background(Color.white)
    }
}

struct MediaListFeaturedViewPreviews: PreviewProvider {
    static var previews: some View {
        VStack{
            Spacer()
            MediaListFeaturedView(onPlay: {_ in})
            Spacer()
        }
        .fullScreenFrame
        .background(Color.primaryRed)
        .multiPreview
    }
}
