//
//  get.parent.control.api.call.service.swift
//  MrArthur
//
//  Created by IPS-169 on 13/09/22.
//

import Foundation
struct getParentControlSettingParameter{
    let parameter = [String:Any]()
}

//ParentalControlSettingsJSONBResponseModel
struct GetParentControlSettingAPICall{
    func getSetting(
        completion: @escaping (Bool, String?, ParentalControlSettingsResponse?) -> ()
    ) {
        let parameters: [String: Any] =  [String:Any]()
        if let token = CurrentUserService.getToken() {
            let attendeeUDID =  UtilityMethod().getValueForKey(key: ConstantOfApp.kAttendeeUUID) as? String ?? ""
            let strParentSettingURL = "\(attendeeUDID)/parental-control-settings"
            APIHelper().callAPI(
                URLString: ConstantHttp.getParentSettingURL + strParentSettingURL,
                methodName: .get,
                param: parameters,
                withToken: token
            ) { data in
                if let resData: ParentalControlSettingsResponse = try? APIHelper.shared.decodeStickers(from: data) {
                    completion(true, "", resData)
                } else {
                    completion(false, "Can not decode the model", nil)
                }
            } fail: { errorMessage in
                print("Fail to register device with error: \(errorMessage)")
                completion(false, errorMessage, nil)
            }
        }
    }
}
