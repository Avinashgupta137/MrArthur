//
//  parent.control.service.swift
//  MrArthur
//
//  Created by IPS-169 on 13/09/22.
//

import Foundation

class ParentControlSetting {
   // static let parentControl = ParentalControlSettingsJSONBResponseModel?
    
    static func getParentControlSettingAPICall(completion: @escaping(Bool, ParentalControlSettingsResponse?)->()) {
        GetParentControlSettingAPICall().getSetting { status, message, parentControlSettingResponse in
            print("response of parent control setting is = \(String(describing: parentControlSettingResponse))")
           // ParentControlSetting.parentControl = parentControlSettingResponse
            completion(status, parentControlSettingResponse)
        }
    }
    
    static func updateParentControlSettingAPICall(
        preset: EParentalControlSettingsPreset,
        compeletion:@escaping(Bool, String, ParentalControlSettingsResponse?)->()
    ){
        UpdateParentControlSettingAPICall().updateSetting(
            param: updateParentControlSettingParameter.init(preset: preset)
        ) { status , message, parentControlSettingResponse in
//            print("response of parent control setting is = \(String(describing: parentControlSettingResponse))")
            compeletion(status, message, parentControlSettingResponse)
        }
    }
}
