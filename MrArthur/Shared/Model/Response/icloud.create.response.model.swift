//
//  icloud.create.response.model.swift
//  MrArthur
//
//  Created by IPS-169 on 15/09/22.
//

import Foundation
struct ICloudCreateResponse:Decodable,Identifiable{
    var id: String?
    var uuid:String
    var userRecordId:String?
    var settingsJSONB:ParentalControlSettingsJSONBResponseModel?
    var createdAt:String?
    var updatedAt:String?
    var restPeriod:EResetTime?
    var preset:EParentalControlSettingsPreset?
}
