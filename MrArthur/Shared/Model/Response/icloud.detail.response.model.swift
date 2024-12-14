//
//  icloud.detail.response.model.swift
//  MrArthur
//
//  Created by IPS-169 on 13/09/22.
//

import Foundation
struct ICloudDetailResponse:Decodable,Identifiable{
    var id: String?
    var uuid:String
    var userRecordId:String?
    var settingsJSONB:ParentalControlSettingsJSONBResponseModel?
    var preset:EParentalControlSettingsPreset?
    var createdAt:String?
    var updatedAt:String?
    var deviceIosList:[iOSDevice]
    
    
}
struct iOSDevice:Decodable{
    var uuid:String
    var name:String?
    var model:String?
    var iosIcloudAccountId:Int
    var timeZoneSecondsFromGMT:String?
    var appVendorIdentifier:String?
    var pushNotificationToken:String?
    var createdAt:String?
    var language:String
    var updatedAt:String
    var appIdentifier:String?
}

