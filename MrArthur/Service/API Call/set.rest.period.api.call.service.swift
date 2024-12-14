//
//  set.rest.period.api.call.service.swift
//  MrArthur
//
//  Created by IPS-169 on 13/09/22.
//

import Foundation


struct SetRestPeriodAPIParameter: Codable {
    let restPeriod: EResetTime
}

struct SetRestPeriodAPICall{
    
    func setRestPeriod(
        param:SetRestPeriodAPIParameter,
        completion: @escaping (Bool,String, ParentalControlSettingsResponse?) -> ()
    ) {
        if let parameters: [String: Any] = try? param.asDictionary(){
            let attendeeUDID =  UtilityMethod().getValueForKey(key: ConstantOfApp.kAttendeeUUID) as? String ?? ""
            let strParentSettingURL = "\(attendeeUDID)/parental-control-settings/rest-period"
            
            if let token = CurrentUserService.getToken() {
                APIHelper().callAPI(
                    URLString: ConstantHttp.getRestPeriodURL + strParentSettingURL,
                    methodName: .post,
                    param: parameters,
                    withToken: token
                ) { data in
                    if let resData: ParentalControlSettingsResponse = try? APIHelper.shared.decodeStickers(from: data) {
                        completion(true, "", resData)
                    } else {
                        completion(true, "Can not decode the model", nil)
                    }
                } fail: { errorMessage in
                    print("Fail to register device with error: \(errorMessage)")
                    completion(true, errorMessage, nil)
                }
            }
        }
    }
}
