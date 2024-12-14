//
//  purshasely.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 01/12/2022.
//

import Foundation
import Purchasely
import Amplitude

class PurshaselyService {
    static var shared: PurshaselyService = PurshaselyService()
    var succedeed: Bool = false
    
    struct keys {
        // Staging
        static let ONBOARDING_STAGING: String = "staging_onboarding"
        static let SCREEN_BLOCK_STAGING: String = "softlaunch_blockscreen_dashboard_staging"
        // Production
        static let ONBOARDING: String = "onboarding_softlaunch_1"
        static let SCREEN_BLOCK: String = "softlaunch_blockscreen_dashboard"
    }
    
    static func getOnboardingPlacementId() -> String {
#if ENV_DEV
        let placementId: String = PurshaselyService.keys.ONBOARDING_STAGING
#elseif ENV_STAGE
        let placementId: String = PurshaselyService.keys.ONBOARDING_STAGING
#elseif ENV_SEBASTIEN
        let placementId: String = PurshaselyService.keys.ONBOARDING_STAGING
#elseif ENV_PROD
        let placementId: String = PurshaselyService.keys.ONBOARDING
#endif
        return placementId
    }
    
    static func getScreenBlockPlacementId() -> String {
#if ENV_DEV
        let placementId: String = PurshaselyService.keys.SCREEN_BLOCK_STAGING
#elseif ENV_STAGE
        let placementId: String = PurshaselyService.keys.SCREEN_BLOCK_STAGING
#elseif ENV_SEBASTIEN
        let placementId: String = PurshaselyService.keys.SCREEN_BLOCK_STAGING
#elseif ENV_PROD
        let placementId: String = PurshaselyService.keys.SCREEN_BLOCK
#endif
        return placementId
    }
    
    func start(completion: @escaping(Bool) -> Void) {
        if (!succedeed) {
            // PURSHASELY
//            let email: String? = UtilityMethod().getValueForKey(key: ConstantOfApp.kEmailId) as? String
            let email: String? = UtilityMethod().getValueForKey(key: ConstantOfApp.kObserverEmail) as? String

            if let email = email {
#if ENV_DEV
                let purshaselyApiKey: String = "ca2db4b0-1b1d-4888-9cc3-37d9c4b026f7"
#elseif ENV_STAGE
                let purshaselyApiKey: String = "ca2db4b0-1b1d-4888-9cc3-37d9c4b026f7"
#elseif ENV_SEBASTIEN
                let purshaselyApiKey: String = "ca2db4b0-1b1d-4888-9cc3-37d9c4b026f7"
#elseif ENV_PROD
                let purshaselyApiKey: String = "04e749e2-02b2-41ab-a898-2db826adb9ed"
#endif

                let amplitudeUserId = UtilityMethod().getValueForKey(key: ConstantOfApp.kObserverUUID) as? String ?? "" // Amplitude.instance().getUserId()
                Purchasely.setAttribute(.amplitudeUserId, value: String(amplitudeUserId)) // CloudKitService.getAnonymousIcloudId()))

                let amplitudeDeviceId = Amplitude.instance().getDeviceId()
                Purchasely.setAttribute(.amplitudeDeviceId, value: String(amplitudeDeviceId))
                
                Purchasely.start(
                    withAPIKey: purshaselyApiKey,
                    appUserId: email,
                    runningMode: .full,
                    eventDelegate: nil,
                    logLevel: .debug
                ) { (success, error) in
                    print(success)
                    if (success) {
                        self.succedeed = true
                    }
                    completion(self.succedeed)
                }
            }
        }
        completion(self.succedeed)
    }
    
    static func preload() {
        let amplitudeUserId = UtilityMethod().getValueForKey(key: ConstantOfApp.kObserverUUID) as? String
        if let amplitudeUserId = amplitudeUserId {
            PurshaselyService.shared.start() { _ in }
        }
    }
    
//    static func SubscriptionIsValid(completion: @escaping(Bool) -> Void) {
//        Purchasely.userSubscriptions(success: { (subscriptions) in
//            // Subscription object contains the plan purchased and the source it was purchased from (iOS or Android)
//            // Calling unsubscribe() will either switch the user to its AppStore settings
//            // or display a procedure on how to unsubscribe on Android
////            for i in subscriptions {
////                let subscription = subscriptions[i]
//////                subscription.
////            }
//        }, failure: { (error) in
//            // Display error
//        })
//    }
}
