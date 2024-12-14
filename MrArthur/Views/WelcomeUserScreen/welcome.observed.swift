//
//  welcome.observed.swift
//  MrArthur
//
//  Created by Troo on 22/08/22.
//

import SwiftUI
extension WelcomeView {

    class Observed: ObservableObject {
        
        func fetchLaunchResponse(completion: @escaping (String, Bool) -> ()) {
            FirstLaunchAPICall().apiCall { errorMsg, response  in
                DispatchQueue.main.async {
                    
                    
                    if ((errorMsg ?? "").count == 0) {
                        if let launchobjresponse = response {
                            UtilityMethod().saveindefault(value: launchobjresponse.token, key: ConstantOfApp.kobserverusertoken)
                            UtilityMethod().saveindefault(value: launchobjresponse.user.uuid, key: ConstantOfApp.kuuid)
                            UtilityMethod().saveindefault(value: launchobjresponse.user.type, key: ConstantOfApp.kusertype)
                            UtilityMethod().saveindefault(value: launchobjresponse.user.role, key: ConstantOfApp.kuserrole)
                            UtilityMethod().saveindefault(value: launchobjresponse.user.subscriptionRoleList.first?.subscription.uuid ?? "", key: ConstantOfApp.kuuidforsubscription)
                            
                            if let stepList = launchobjresponse.user.subscriptionRoleList.first?.subscription.subscriptionOnboarding.stepListJsonb.stepList {
                                let screenName = stepList.map({$0.name ?? ""})
                                UtilityMethod().saveindefault(value:screenName, key: ConstantOfApp.kscreenNameList)
                            }
                        }
                        completion("", true)
                    } else {
                        completion((errorMsg ?? ConstantOfApp.errorDefMessage), false)
                    }
                }
            }
        }
        
    }
}
