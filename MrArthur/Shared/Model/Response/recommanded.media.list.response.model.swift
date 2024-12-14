//
//  recommanded.media.list.response.model.swift
//  MrArthur
//
//  Created by IPS-157 on 17/09/22.
//

import Foundation
struct RecommandedAppListResponseModel: Codable, Identifiable {
    var id : Int?
    var uuid : String?
    var name : String?
    var comment : String?
    var devicePlatform : String?
    var deviceTypeList: [String]?
    var category: String?
    var link: String?
    var createdAt: String?
    var updatedAt: String?
    var appCategoryList: [AppCategory]?
    
    var catList: [AppCategory] {
        return appCategoryList ?? []
    }
    var appUuid : String{
        return uuid ?? ""
    }
    var appLink : String{
        return link ?? ""
    }
    var appName : String {
        return name ?? ""
    }
    var appComment : String{
        return comment ?? ""
    }
}
