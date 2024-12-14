//
//  attendee.howitwork.context.observer.swift
//  MrArthur
//
//  Created by BAPS on 07/12/22.
//

import Foundation


class ATTHowItWorkObserver:ObservableObject{
    @Published var iReducedTotalScreenTimePercent: Int = 0
    @Published var iEducationalTotalScreenTimePercent: Int = 0
    @Published var sReducedTotalScreenTime = "00h00"
    @Published var sEducationalTotalScreenTime = "00h00"
    var totalTimeMinutes : Int = 0
    var educativeTimeMinutes : Int = 0

    init() {
        MediationService().fetchMediationInfo { message, res, status in
            if let data = res.stepListJsonb?.list?.last {
                self.iReducedTotalScreenTimePercent = data.totalTimeReductionPercent ?? 0
                self.iEducationalTotalScreenTimePercent = data.educativeTimePercent ?? 0
                self.totalTimeMinutes = data.totalTimeMinutes ?? 0
                self.educativeTimeMinutes = data.educativeTimeMinutes ?? 0
                self.setEducationalTime(iEducationalTime: self.educativeTimeMinutes)
                self.setTotalTime(iTotalScreenTime: self.totalTimeMinutes)
            }
        }
    }
    private func setEducationalTime(iEducationalTime: Int) {
        let (h,m,_) = UtilityMethod.minutesToHoursMinutesSeconds(iEducationalTime)
        self.sEducationalTotalScreenTime = h.toTimeFormate + "h" + m.toTimeFormate
    }
    private func setTotalTime(iTotalScreenTime: Int) {
        let (h,m,_) = UtilityMethod.minutesToHoursMinutesSeconds(iTotalScreenTime)
        self.sReducedTotalScreenTime = h.toTimeFormate + "h" + m.toTimeFormate
    }

    private func roundToOneDecimalPlace(_ x: Double) -> Int {
        let value = Double(round(1 * x) / 1)
        return Int(value)
    }
}
