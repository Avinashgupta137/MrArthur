//
//  purshasely.paywall.swift
//  MrArthur
//
//  Created by Reille Sebastien on 01/12/2022.
//

import Foundation


import Foundation
import Purchasely
import SwiftUI

struct PurchaselyPaywall: UIViewControllerRepresentable {

    typealias UIViewControllerType = UIViewController
    
    let placementId: String
    let paywallFinishedCallback: ((Bool) -> Void)
    
    init(placementId: String, paywallFinishedCallback: @escaping ((Bool) -> Void)) {
        self.placementId = placementId
        self.paywallFinishedCallback = paywallFinishedCallback
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
//        dump("subscription uuid \(UtilityMethod().getValueForKey(key: ConstantOfApp.kUUIDForSubscription) as? String)")
            
        guard let paywall = Purchasely.presentationController(
            for: placementId,
            contentId: UtilityMethod().getValueForKey(key: ConstantOfApp.kUUIDForSubscription) as? String
                ?? "",
            completion: { result, plan in
//                UtilityMethod.checkUserSubscription { _ in
//                let resultString: String = {
//                    switch result {
//                    case .purchased:
//                        return "purchased"
//                    case .cancelled:
//                        return "cancelled"
//                    case .restored:
//                        return "restored"
//                    default:
//                        return "UNDEFINED"
//                    }
//                }()
//                AppsFlyerService.logEvent(
//                    key: EAppsFlyerEventKey.PAYWALL,
//                    withValues: [
//                        "status": resultString,
//                        "placementId": placementId,
//                        "plan": plan?.name ?? "NULL"
//                ])
                    switch result {
                    case .purchased:
                        print("purchased")
//                        AppState.shared.hasValidSubscription = true
                        self.paywallFinishedCallback(true)
                    case .cancelled:
                        print("cancelled")
//                        SubscriptionService.checkUserSubscription()
                        self.paywallFinishedCallback(false)
                    case .restored:
                        print("restored")
//                        AppState.shared.hasValidSubscription = true
                        self.paywallFinishedCallback(true)
                    @unknown default:()
                    }
//                }
        }) else {
            self.paywallFinishedCallback(false)
            return UIViewController()
        }
        return paywall
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
