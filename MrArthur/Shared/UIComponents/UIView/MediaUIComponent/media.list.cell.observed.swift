//
//  media.list.cell.observed.swift
//  MrArthur
//
//  Created by IPS-169 on 21/09/22.
//

import SwiftUI
import AVFoundation

extension MediaListCellView{
    class MediaListCellObserved:ObservableObject{
    
        func getDuration(url:URL)->String{
            let asset = AVURLAsset(url: url)
            let durationInSeconds = asset.duration.seconds
            return String.init(format:"\(durationInSeconds)")
        }
        
        func getDurationOfVideo(video:YoutubeMedia)->String{
            var str = "0 min"
            let hours = video.ytDurationHour
            let mins = video.ytDurationMinute
            if(hours > 0){
                str = "\(hours)h"
                if(mins > 0){
                    str += "\(mins)"
                }
            } else {
                if(mins > 0){
                    str = "\(mins)m"
                }
            }
            return str
        }
        
        func shareMedia(_ videoId: String){
            let urlMedia = "https://www.youtube.com/watch?v=\(videoId)"
            print("URL Media :\(urlMedia)")
            guard let urlShare = URL(string: urlMedia) else { return }
            let message = "Found it grace to mr.Arthur! Love it!"

            AppShared.shareSheet(items: [urlShare, message])

        }
    }
}
