//
//  installed.app.response.model.swift
//  MrArthur
//
//  Created by IPS-157 on 17/09/22.
//

import Foundation

struct InstallAppResponseModel: Codable, Identifiable {
    let id : Int?
    let uuid : String
    let name : String
    let comment : String
    let devicePlatform: String
    let deviceTypeList : [String]
    let category : String
    let link : String
    let createdAt: String
    let updatedAt: String
}
