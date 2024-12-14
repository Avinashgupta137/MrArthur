//
//  update.parent.control.response.model.swift
//  MrArthur
//
//  Created by IPS-169 on 15/09/22.
//

import Foundation
struct UpdateParentControlResponseModel:Decodable {
    var id:String?
    var createdAt:String?
    var deviceIosList:[iOSDevice]?
    var parentalControlSettingsJSONB:ParentalControlSettingsJSONBResponseModel?
    var parentControlSettingsJSONB:ParentalControlSettingsJSONBResponseModel?
    var parentControlSettingsPreset:EParentalControlSettingsPreset?
    var parentalControlSettingsPreset:EParentalControlSettingsPreset?
    var restPeriod:EResetTime?
    var updatedAt:String?
    var userRecordId:String?
    var uuid:String?
}
