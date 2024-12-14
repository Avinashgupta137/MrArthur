//
//  media.response.model.swift
//  MrArthur
//
//  Created by Troo on 05/09/22.
//

import Foundation

struct MediaHelper {
    static let shared: MediaHelper = MediaHelper()
    
    private let dummyArteMedia: MediaDetails = MediaDetails(
        id: UUID().uuidString,
        thumbnail: "ic_thumbnail",
        duration: 30,
        title: "THIS IS THE TWO LINES FOR THE MEDIA TITLE",
        category: "Category",
        createdAt: "01/01/2022",
        description: "This the text zone in order to pitch the media in few words within five lines max. But it can also be shorter.",
        src: "https://www.arte.tv/player/v7/index.html",
        jsonUrl: "https://api.arte.tv/api/player/v2/config/en/058387-000-A",
        lang: "en_EN",
        autoPlay: true,
        mute: 0,
        previewData: MediaPreviewData(
            title: "Elsa Schiaparelli",
            subtitle: "Fashion as Art",
            image: "https://api-cdn.arte.tv/img/v2/image/DEwfLJEswsFYu7ZZStHcH7/940x530"
        ),
        providerType: .ARTE
    )
    
    private let dummyYTMedia: MediaDetails = MediaDetails(
        id: UUID().uuidString,
        thumbnail: "ic_thumbnail",
        duration: 30,
        title: "THIS IS THE TWO LINES FOR THE MEDIA TITLE",
        category: "Category",
        createdAt: "01/01/2022",
        description: "This the text zone in order to pitch the media in few words within five lines max. But it can also be shorter.",
        videoId: "ux6zXguiqxM",
        providerType: .YOUTUBE
    )
    
    func dummySectionData() -> MediaSection {
        return MediaSection(
            title: "DIGITAL HEALTH".localized,
            list: [
                dummyYTMedia,
                dummyYTMedia,
                dummyYTMedia
            ])
    }
}

struct MediaSection: Codable, Identifiable {
    var id: String?
    var title: String?
    var list: [MediaDetails]?
    
    var sectionTitle: String {
        return title ?? "NA"
    }
    
    var sectionList: [MediaDetails] {
        return list ?? []
    }
}


struct MediaDetails: Codable, Identifiable {
    var id: String?
    var thumbnail: String?
    var duration: Int?
    var title: String?
    var category: String?
    var createdAt: String?
    var description: String?
    var url: String?
    //
    var videoId: String?
    var src: String?
    var jsonUrl: String?
    var lang: String?
    var autoPlay: Bool?
    var mute: Int?
    var previewData: MediaPreviewData?
    var providerType: EVideoMediaProviderType?

    
    var mediaDuration: String {
        return (duration ?? 0).toTimeFormate + " min"
    }
    
    var mediaUrl: String {
        return url ?? "https://www.arte.tv/en/videos/108955-000-A/franz-ferdinand/"
    }
    
    var mediaType: EVideoMediaProviderType {
        return providerType ?? .ARTE
    }
    
    var medialHtmlString: String {
        return getHtmlString(mediaType)
    }
    
    var mediaYTThumnailUrl: URL? {
        return URL(string: "https://img.youtube.com/vi/\(videoId ?? "")/maxresdefault.jpg")
    }
    
    private func getHtmlString(_ mediaType: EVideoMediaProviderType) -> String {
        
        let body = ((mediaType == .ARTE)
                    ? getArteHTMLString()
                    : getYouTubeHTMLString()) ?? ""
        return """
        <html>
        <head>
            <title>Mr Arthur</title>
            <style>
            body {
              background-color: #FFF5F7;
            }
            </style>
        </head>
        \(body)
        </html>
"""
    }
    
    private func getArteHTMLString() -> String? {
        var source = ""
        if let srcUrl = src,
           let jUrl = jsonUrl,
           let language = lang,
           let isAutoPlay = autoPlay,
           let isMute = mute,
           let data = try? previewData?.asDictionary()
        {
            guard var urlComponents = URLComponents(string: srcUrl) else {
                print("Invalid endpoint")
                return nil
            }
            if let pData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) {
                let pJson = String(data: pData, encoding: .ascii) ?? ""
                let parameters = [
                    "json_url": jUrl,
                    "lang": language,
                    "autoplay": isAutoPlay,
                    "mute": isMute,
                    "previewData": pJson,
                ] as [String: Any]
                // Build an array containing the parameters the user specified
                let queryItems = parameters.map { key, value in URLQueryItem(name: key, value: "\(value)") }
                // Add these parameters to the URLComponents
                urlComponents.queryItems = queryItems
                guard let url = urlComponents.url else {
                    print("Cannot construct URL")
                    return nil
                }
                source = url.absoluteString
            } else {
                return nil
            }
        } else {
            return nil
        }
        return """
        <body>
            <iframe
                allowfullscreen="true"
                style="
                    transition-duration:0;
                    transition-property:no;
                    margin:0 auto;
                    position:relative;
                    display:block;
                    background-color:#000000;
                "
                frameborder="0"
                scrolling="no"
                width="100%"
                height="100%"
                src='\(source)'
            ></iframe>
        </body>
"""
    }
    
    private func getYouTubeHTMLString() -> String? {
        
        return """
          <body>
            <div id="player"></div>
            <script>
              var tag = document.createElement('script');
              tag.src = "https://www.youtube.com/iframe_api";
              var firstScriptTag = document.getElementsByTagName('script')[0];
              firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
              var player;
              function onYouTubeIframeAPIReady() {
                player = new YT.Player('player', {
                  height: '100%',
                  width: '100%',
                  videoId: '\(videoId ?? "")',
                  playerVars: {
                    'playsinline': 1
                  },
                  events: {
                    'onReady': onPlayerReady,
                    'onStateChange': onPlayerStateChange
                  }
                });
              }

              function onPlayerReady(event) {
                event.target.playVideo();
              }
              //YT.PlayerState.ENDED or 0
              //YT.PlayerState.PLAYING or 1
              //YT.PlayerState.PAUSED or 2
              //YT.PlayerState.BUFFERING or 3
              //YT.PlayerState.CUED or 5
              var done = false;
              function onPlayerStateChange(event) {
                if (event.data == YT.PlayerState.PLAYING && !done) {
                  done = true;
                }
                var data = "onPlayerStateChange " + event.data;
                window.webkit.messageHandlers.iOSNative.postMessage(data);
              }
              function stopVideo() {
                player.stopVideo();
                var time = player.playerInfo.currentTime;
                window.webkit.messageHandlers.iOSNative.postMessage({'watch_time' : time});
              }
            </script>
          </body>
"""
    }
}

enum EVideoMediaProviderType: String, Codable {
    case YOUTUBE = "YOUTUBE"
    case ARTE = "ARTE"
}

struct MediaPreviewData: Codable {
    var title: String?
    var subtitle: String?
    var image: String?
}
