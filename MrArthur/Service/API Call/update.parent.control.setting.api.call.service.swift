//
//  update.parent.control.setting.api.call.service.swift
//  MrArthur
//
//  Created by IPS-169 on 13/09/22.
//

import Foundation

struct updateParentControlSettingParameter: Codable {
    var preset: EParentalControlSettingsPreset? = nil
}

struct UpdateParentControlSettingAPICall{
    func updateSetting(
        param: updateParentControlSettingParameter,
        completion: @escaping (Bool,String, ParentalControlSettingsResponse?) -> ()
    ) {
        var status = false
        if let parameters: [String: Any] = try? param.asDictionary(){
            var parentalControlSettings: ParentalControlSettingsResponse?
            if let token = CurrentUserService.getToken() {
                print("Child ID: - \(CloudKitService.getiCloudAccountUUID()))")
                APIHelper().callAPI(
                    URLString: ConstantHttp.updateParentControlSettingURL,
                    methodName: .post,
                    param: parameters,
                    withToken: token
                ) { data in
                    let data = Data(data)
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
}
