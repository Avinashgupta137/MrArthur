//
//  subscription.api.call.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 23/01/2023.
//

import Foundation

struct SubscriptionApiCallService {
    
    static func getSubscriptionValidity (
        completion: @escaping (String?, SubscriptionIsValidREsponseModel?) -> ()
    ) {
        if let userSubscriptionId = UtilityMethod().getValueForKey(key: ConstantOfApp.kUUIDForSubscription) as? String {
            let url = ConstantHttp.validateSubscriptionURL + userSubscriptionId + "/validity"
            APIHelper.shared.callAPI(
                URLString: url.trimmingCharacters(in: .whitespaces),
                methodName: .get,
                withToken: ConstantOfApp.kObserverTokenSend
            ) { data in
                if let model: SubscriptionIsValidREsponseModel = try? APIHelper.shared.decodeDataToModel(
                    from: data
                ) {
                    completion(nil, model)
                } else {
                    completion("Can not decode the model", nil)
                }
            } fail: { errorMessage in
                print("error is = \(errorMessage) validateSubscription")
                completion(errorMessage, nil)
            }
        }
        
    }
    
    static func postSubscriptionStartTrial (completion: @escaping(Bool) -> ()) {
        if let userSubscriptionId = UtilityMethod().getValueForKey(key: ConstantOfApp.kUUIDForSubscription) as? String {
            let url = ConstantHttp.validateSubscriptionURL + userSubscriptionId + "/trial/create"
            APIHelper.shared.callAPI(
                URLString: url.trimmingCharacters(in: .whitespaces),
                methodName: .post,
                withToken: ConstantOfApp.kObserverTokenSend
            ) { _ in
                completion(true)
//                if let model: SubscriptionIsValidREsponseModel = try? APIHelper.shared.decodeDataToModel(
//                    from: data
//                ) {
//                    completion(nil, model)
//                } else {
//                    completion("Can not decode the model", nil)
//                }
            } fail: { errorMessage in
                print("error is = \(errorMessage) validateSubscription")
//                completion(errorMessage, nil)
                completion(false)
            }
        }
        
    }
}
