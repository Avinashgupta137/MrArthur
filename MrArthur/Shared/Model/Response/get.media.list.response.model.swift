//
//  get.media.list.response.model.swift
//  MrArthur
//
//  Created by IPS-169 on 17/09/22.
//

import Foundation

struct GetMediaListResponseModel: Codable  {
    
    var youtubeMedia: [YoutubeMedia]?
    var ytMediaList: [YoutubeMedia] {
        youtubeMedia ?? []
    }
    var categories: [MediaCategory] {
        let list = ytMediaList.compactMap({$0.ytMediaCategoryList}).reduce([], +)
        return Array(Set(list))
    }
    
}

// MARK: - YoutubeMedia
struct YoutubeMedia: Codable , Identifiable {
    var id: Int?
    var durationHour: Int?
    var durationMinute: Int?
    var durationSecond: Int?
    var position: Int?
    var uuid: String?
    var title: String?
    var description: String?
    var videoId: String?
    var countryList: [String]?
    var categoryList: [String]?
    var active: String?
    var createdAt: String?
    var updatedAt: String?
    var mediaCategoryList: [MediaCategory]?
    
    
    var ytId: Int {
        return id ?? 0
    }
    var ytDurationHour: Int {
        return durationHour ?? 0
    }
    var ytDurationMinute: Int {
        return durationMinute ?? 0
    }
    var ytDurationSecond: Int {
        return durationSecond ?? 0
    }
    var ytPosition: Int {
        return position ?? 0
    }
    var ytUuid: String {
        return uuid ?? ""
    }
    var ytTitle: String {
        return title ?? ""
    }
    var ytDescription: String {
        return description ?? ""
    }
    var ytVideoId: String {
        return videoId ?? ""
    }
    var ytCountryList: [String] {
        return countryList ?? []
    }
    var ytCategoryList: [String] {
        return categoryList ?? []
    }
    var ytActive: String {
        return active ?? ""
    }
    var ytCreatedAt: String {
        return createdAt ?? ""
    }
    var ytUpdatedAt: String {
        return updatedAt ?? ""
    }
    var ytMediaCategoryList: [MediaCategory] {
        return mediaCategoryList ?? []
    }
}

struct MediaCategory: Codable, Hashable, Identifiable {
    var id: Int?
    var createdAt: String?
    var enName: String?
    var frName: String?
    var updatedAt: String?
    var uuid: String?
    
    var catName: String {
        UtilityMethod.isFrench ? (frName ?? "") : (enName ?? "")
    }
}

