//
//  ValidateAPICall.swift
//  MrArthur
//
//  Created by IPS-169 on 19/07/22.
//

import Foundation

struct ValidateAPICall {
    
    static func validateCode (
        withToken: String,
        parameter: [String: Any],
        completion: @escaping (String?, ValidationCodeResponseModel?) -> ()
    ) {
        
        APIHelper.shared.callAPI(
            URLString: ConstantHttp.validateCodeURL.trimmingCharacters(in: .whitespaces),
            methodName: .post,
            param: parameter,
            withToken: withToken
        ) { data in
            if let response: ValidationCodeResponseModel = try? APIHelper.shared.decodeStickers(from: data) {
                
                UtilityMethod().saveInDefault(value: response.token ?? "", key: ConstantOfApp.kObserverUserToken)
                ExtensionWidgetDataSource.setObserverToken(response.token)
                let _ = CurrentUserService.setToken(token: UtilityMethod().getValueForKey(key: ConstantOfApp.kObserverUserToken) as? String ?? "")
                DeviceService.registerDevice() {_ in}
                UtilityMethod().saveInDefault(value: response.user?.contact?.email, key: ConstantOfApp.kObserverEmail)
                UtilityMethod().saveInDefault(value: response.user?.uuid, key: ConstantOfApp.kObserverUUID)
                PurshaselyService.preload()
                
                // Apps Flyer CUID
                AppsFlyerService.setCUID(cuid: response.user?.uuid)

                completion(nil, response)
            } else {
                completion("Can not decode the model", nil)
            }
            
        } fail: { errorMessage in
            print("error is = \(errorMessage) for onboarding api call")
            completion(errorMessage, nil)
        }
    }
}
