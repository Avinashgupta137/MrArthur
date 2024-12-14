//
//  FirstLaunchAPICall.swift
//  MrArthur
//
//  Created by IPS-169 on 13/07/22.
//

import Foundation

struct FirstLaunchAPICall {
       
    static func request(completion: @escaping (String?, FirstLaunch?) -> ()) {
        APIHelper.shared.callAPI(
            URLString: String.init(format: "\(ConstantHttp.constantFirstLaunchURL)"),
            methodName: APICallMethodType.get,
            param: [String: Any](),
            withToken: ConstantOfApp.kNoneTokenSend
        ) { data in
            if let model: FirstLaunch = try? APIHelper.shared.decodeStickers(from: data) {
                // save data
                self.saveData(model)
                
                // Set token
                let _ = CurrentUserService.setToken(token: model.token ?? "")
                
                // Apps Flyer CUID
                AppsFlyerService.setCUID(cuid: model.user?.uuid)
                
                // Register device
                DeviceService.registerDevice() { success in }
                
                completion(nil, model)
            } else {
                completion("Can not decode the model", nil)
            }
            
        } fail: { error in
            print("error is = \(error)")
            completion(error, nil)
        }
        
    }
    
    private static func saveData(_ response: FirstLaunch) {
        UtilityMethod().saveInDefault(
            value: response.token ?? "",
            key: ConstantOfApp.kObserverUserToken
        )
        
        UtilityMethod().saveInDefault(
            value: response.user?.type ?? "",
            key: ConstantOfApp.kUserType
        )
        
        UtilityMethod().saveInDefault(
            value: response.user?
                .subscriptionRoleList?
                .first?.subscription?
                .uuid ?? "", key: ConstantOfApp.kUUIDForSubscription
        )
        
        if let stepList = response.user?
            .subscriptionRoleList?
            .first?.subscription?
            .subscriptionOnboarding?
            .stepListJsonb?
            .stepList {
            let screenName = stepList.map({$0.name ?? ""})
            UtilityMethod().saveInDefault(value:screenName, key: ConstantOfApp.kScreenNameList)
        }
    }
}
