//
//  reset.time.service.swift
//  MrArthur
//
//  Created by IPS-169 on 14/09/22.
//

import Foundation

class ResetTimeSetting{
   // static let parentControl = ParentalControlSettingsJSONBResponseModel?
    
    static func resetTimeSettingAPICall(){
        GetRestPeriodAPICall().getRestPeriod { message, resetPeriodGetAPIResponse in
            print("response of reset Period Get API setting is = \(String(describing: resetPeriodGetAPIResponse))")
        }
        
    }
    
    static func updateresetTimeSettingAPICall(
        restPeriod: EResetTime,
        compeletion: @escaping(Bool, String, ParentalControlSettingsResponse?)->()
    ){
        let requestparaForUpdateResetTime = SetRestPeriodAPIParameter(restPeriod: restPeriod)
        SetRestPeriodAPICall().setRestPeriod(param: requestparaForUpdateResetTime) { status, message, setRestAPIResponse in
            print("response of reset Period Get API setting is = \(String(describing: setRestAPIResponse))")
            compeletion(status, message, setRestAPIResponse)
        }
        
    }
}
