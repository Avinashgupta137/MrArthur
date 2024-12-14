//
//  observer.benefit.details.obsever.swift
//  MrArthur
//
//  Created by Amit Sinha on 15/11/22.
//

import Foundation

extension ObserverEducationalBenefitDetailsView {
    class OBSBenefitDetailsObserver: ObservableObject {
        let attendee = UserDefaultsHelper.selectedAttendee
        var educationalCommintementTime : Int = 0
        @Published var totalDay : Int = 0
        @Published var userName : String = ""
        
        init(){
            self.userName = attendee?.attendeeName ?? ""
            educationalScreenTimeCommintment()
            
        }
        private func educationalScreenTimeCommintment() {
            if let estimation = attendee?.attendeeUserMediationList?.last?.stepListJsonb?.estimation {
                let diagnziedScreenTime = estimation.diagnosedScreenTimeMinutes ?? 0
                if let data  = self.attendee?.attendeeUserMediationList?.last?.stepListJsonb?.list?.last {
                    let reducedScreenTimePercent = data.totalTimeReductionPercent ?? 0
                    let increasedEducationTimePercent = data.educativeTimePercent ?? 0
                    
                    let calculation: Double = 1.0 - (Double(reducedScreenTimePercent)/100)
                    let totalScreenTimeAfterGoal = Double(
                        Double(diagnziedScreenTime)  * calculation
                    ).toCeilInt
                    let educationalAfterGoalScreenTime = Double(totalScreenTimeAfterGoal) * Double(increasedEducationTimePercent) / 100
                    educationalCommintementTime = (educationalAfterGoalScreenTime.toCeilInt)
                    
                    let xxxMinu = Double(7300) / Double(educationalCommintementTime)
                    totalDay = roundToOneDecimalPlace(xxxMinu)
                }
            }
        }
        private func roundToOneDecimalPlace(_ x: Double) -> Int {
            let value = Double(round(1 * x) / 1)
            return Int(value)
        }
    }
}
