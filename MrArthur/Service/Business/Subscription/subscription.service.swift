//
//  Subscription.swift
//  MrArthur
//
//  Created by IPS-157 on 07/07/22.
//

import Foundation

class SubscriptionService {
    static func paywallHasToBePresented(completion: @escaping(Bool) -> ()) {
        SubscriptionApiCallService.getSubscriptionValidity() { error, model in
            if let error = error, !error.isEmpty {
                print("validateSubscription \(error)")
                completion(false)
            } else if let validity = model?.subscriptionValidity {
                let alreadyValid: Bool = validity == ESubscriptionValidity.SUBSCRIPTION_ALREADY_VALID
                let trialOngoing: Bool = validity == ESubscriptionValidity.SUBSCRIPTION_TRIAL_ONGOING
                if (alreadyValid || trialOngoing) {
                    completion(false)
                } else {
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }
    
    static func startBackendTrial(completion: @escaping(Bool) -> ()) {
        SubscriptionApiCallService.getSubscriptionValidity { error, model in
            if let validity = model?.subscriptionValidity {
                let trialNotStarted: Bool = validity == ESubscriptionValidity.SUBSCRIPTION_TRIAL_NOT_STARTED
                if (trialNotStarted) {
                    SubscriptionApiCallService.postSubscriptionStartTrial() { success in
                        completion(true)
                    }
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
    static func setBlockScreenStatus() -> Void {
        SubscriptionService.paywallHasToBePresented() { hasToBePresented in
            AppState.shared.hasValidSubscription = !hasToBePresented
        }
    }
}
