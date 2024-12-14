//
//  media.observed.swift
//  MrArthur
//
//  Created by IPS-157 on 04/08/22.
//

import Foundation

import SwiftUI

class MediaViewObserver: ObservableObject {
    
    @Published var arrOfVideoCategoryWise: [VideoCategoryWiseModel] = []
    
    var mediaList: GetMediaListResponseModel = GetMediaListResponseModel()
    
    init() {
        getMediaList()
        AmplitudeService.sendEvent(
            key: .ATT_MEDIAS_MAIN_LIBRARY_4
        )
    }
    
    func getMediaList() {
        MediaService.getList { status, _, model in
            if status {
                if let mediaList = model {
                    self.mediaList = mediaList
                    self.arrOfVideoCategoryWise = []
                    for category in self.mediaList.categories {
                        let videos = self.mediaList
                            .ytMediaList
                            .filter({$0.ytMediaCategoryList.contains(where: {$0.id == category.id})})
                        self.arrOfVideoCategoryWise.append(VideoCategoryWiseModel(catName: category.catName, video: videos))
                    }
                }
            }
        }
    }
}

