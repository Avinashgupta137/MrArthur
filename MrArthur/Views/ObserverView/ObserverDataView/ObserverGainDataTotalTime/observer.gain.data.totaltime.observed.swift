//
//  observer.gain.data.totaltime.observed.swift
//  MrArthur
//
//  Created by IPS-157 on 07/09/22.
//


import Foundation
import SwiftUI
extension OBSGainDataTotalTimeView {
    class OBSGainDataTotalTimeViewObserver: ObservableObject {
        
        var diagnosedScreenTimeMinutes: Int = 0
        var day1TimeValue: Int = 0
        var numberOfAfterNoonRulePerYear: Int = 0
        var numberOfComicRulePerYear: Int = 0
        var TotalSavedTimePerYear: Int = 0
        var iSmartPhoneMinutes: Int = 0
        var iTabletMinutes: Int = 0
        var dailySharedScreenTimeMinutes: Int = 0
//        var hasValidSubscription: Bool = false
        let currentUser = UtilityMethod().getValueForKey(key: ConstantOfApp.kCurrentUserRole) as? String
        
        init() {
            self.setData()
//            self.checkSubscription()
        }
        
        func setData() {
            if let attendee = UserDefaultsHelper.selectedAttendee {
                if let estimation = attendee.attendeeUserMediationList?.last?.stepListJsonb?.estimation {
                    self.diagnosedScreenTimeMinutes = estimation.diagnosedScreenTimeMinutes ?? 0
                }
                //-------saved_start_time-------
                self.day1TimeValue = Int(ceil(Double(self.diagnosedScreenTimeMinutes) * 0.2))
                let AfterNoonTime = self.day1TimeValue
                //-------saved_books_time-------
                self.numberOfComicRulePerYear = Int(ceil(Double((AfterNoonTime * 365)/90)))
                //-------saved_afternoon_time-------
                self.numberOfAfterNoonRulePerYear =  Int(ceil(Double((AfterNoonTime * 365)/120)))
                //-------saved_year_time-------
                self.TotalSavedTimePerYear = Int(ceil(Double(AfterNoonTime * 365 / 60)))
            }
        }
        
//        private func checkSubscription() {
//            ValidateAPICall.validateSubscription { error, model in
//                if let error = error, !error.isEmpty {
//                    print("validateSubscription \(error)")
//                } else {
//                    if let model = model {
////                        if isDevelop {
////                            self.hasValidSubscription = true
////                            return
////                        }
//                        let isValid: Bool = model.subscriptionValidity == ESubscriptionValidity.SUBSCRIPTION_ALREADY_VALID
//                        || model.subscriptionValidity == ESubscriptionValidity.SUBSCRIPTION_TRIAL_ONGOING
////                        self.hasValidSubscription = isValid
//                    }
//                }
//            }
//        }
    }
}
