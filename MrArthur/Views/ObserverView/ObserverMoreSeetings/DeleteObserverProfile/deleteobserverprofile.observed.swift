//
//  deleteobserverprofile.observed.swift
//  MrArthur
//
//  Created by IPS-172 on 17/10/22.
//

import Foundation
extension DeleteObserverProfile{
    
    class Observed:ObservableObject{
        func deleteSubscriptionAPI(withToken:String,param:[String:Any],completion:@escaping(String?,Bool)->()){
            let subscriptionValue = UtilityMethod().getValueForKey(key: ConstantOfApp.kUUIDForSubscription) as? String
            let deleteSubscriptionparam = DeleteSubscriptionRequesModel(SubscriptionUUID: subscriptionValue ?? "")
            if let param = try? deleteSubscriptionparam.asDictionary() {
                DeleteSubscriptionAPICall().deleteSubscription(parameter: param) { message, status in
                    print("Child Deleted: \(message) & Status: \(status)")
                    completion(message, status)
                }
            }
        }
    }
}
