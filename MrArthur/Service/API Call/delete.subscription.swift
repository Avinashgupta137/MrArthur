//
//  delete.subscription.swift
//  MrArthur
//
//  Created by IPS-172 on 17/10/22.
//

import Foundation
struct DeleteSubscriptionRequesModel:Codable {
    var SubscriptionUUID:String
}
struct DeleteSubscriptionAPICall{
    
    func deleteSubscription(parameter:[String:Any],completion:@escaping(String, Bool)->()){
        let strSubscriptionUDID =  String.init(format: "\(UtilityMethod().getValueForKey(key: ConstantOfApp.kUUIDForSubscription) as? String ?? "")")
        APIHelper.shared.callAPI(
            URLString: ConstantHttp.deleteSubscriptionURL + strSubscriptionUDID,
            methodName: .delete,
            param: parameter,
            withToken: ConstantOfApp.kObserverTokenSend
        ) { data in
           
            completion("", true)
        } fail: { error in
            completion(error, false)
        }
    }
}
