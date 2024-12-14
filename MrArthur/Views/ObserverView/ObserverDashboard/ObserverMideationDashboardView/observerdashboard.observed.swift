//
//  ObserverDashboardView+Observed.swift
//  MrArthur
//
//  Created by IPS-157 on 26/07/22.
//

import Foundation
import SwiftUI

extension ObserverMideationDashboardView{
    class ObserverMideationDashboardObserver: ObservableObject {
        var publicHealthRecommmendationTime : String = "01h00 / day"
        @Published var showGoalSummary =  false
        @Published var isGoal = false
        @Published var statusOfMeditation = "NA"
        @Published var attendee: AttendeeListResponseModel = AttendeeListResponseModel()
        @Published var iSmartPhoneMinutes: Int = 0
        @Published var iTabletMinutes: Int = 0
        @Published var iEducationalAppMinutes: Int = 0
        @Published var iPublicHealthRecommendations: Int = 0
        @Published var iTotalScreeenTime: Int = 0
        @Published var iEducationScreeenTime: Int = 0
        @Published var iFreeTime: Int = 0
        @Published var iSchoolTime: Int = 0
        @Published var avgScreenTime : String = "00h00"
        @Published var graphScreenTime : Int = 0
        var diagnosedScreenTimeMinutes: Int = 0
        @Published var iTotalScreenTimeMinutes: Int = 0
        @Published var fUpdateDailyConsumption: Int = 0
        @Published var fUpdateBreakActivity: Int = 0
        
        @Published var createdDateOrUpdatedDateOBD = (DateService.shared.getDateMonthYearFromNow())
        @Published var previewUpdatedDate = (DateService.shared.getDateMonthYearFromNow())
        ///Mediation Variabels
        @Published var miAttendeeName = " User "
        @Published var miReducedTotalScreenTimePercent: Int = 0
        @Published var miEducationalTotalScreenTimePercent: Int = 0
        @Published var miReducedTotalScreenTime = "00h00"
        @Published var miEducationalTotalScreenTime = "00h00"
        
        @Published var miMrArthurImage = GoalDetailService.initImage
        @Published var miMrArthurMessage = GoalDetailService.initMessage
        
        var miTotalTimeMinutes : Int = 0
        var miEducativeTimeMinutes : Int = 0
        var mediationData: MediationListResponseModel? = nil
        @Published var miComic = "0 books"
        @Published var miBikeTrip = "0 miles\nbike rides"
        @Published var miAfternoon = "0 afternoon"

        func _init() {
            if let localAttendee = UserDefaultsHelper.selectedAttendee {
                self.attendee = localAttendee
                self.setData()
                self.getDataFromServer()
            } else {
                self.getDataFromServer()
            }
        }
        
        private func getDataFromServer() {
            AttendeeService.shared.getAttendeeByUUID { error, attendee in
                self.fetchMediationInfo {
                    if let attendee = attendee {
                        self.attendee = attendee
                        self.setData()
                    }
                }
            }
        }
        
        private func fetchMediationInfo(completion: @escaping () -> ()) {
            MediationService().fetchMediationInfo { message, res, status in
                if let data = res.stepListJsonb?.list?.last {
                    self.miReducedTotalScreenTimePercent = data.totalTimeReductionPercent ?? 0
                    self.miEducationalTotalScreenTimePercent = data.educativeTimePercent ?? 0
                    self.miTotalTimeMinutes = data.totalTimeMinutes ?? 0
                    self.miEducativeTimeMinutes = data.educativeTimeMinutes ?? 0
                    self.mediationData = data
                }
                if let estimation = res.stepListJsonb?.estimation {
                    if let diagnosedScreenTimeMinutes = estimation.diagnosedScreenTimeMinutes {
                        self.setEducationalTime(iEducationalTime:  self.miEducativeTimeMinutes)
                        self.setTotalTime(iTotalScreenTime: self.miTotalTimeMinutes )
                        let numberOfSaveMinute = abs(diagnosedScreenTimeMinutes - self.miTotalTimeMinutes)
                        self.setActivityData(numberOfSaveMinute: numberOfSaveMinute)
                        let (label, image) = GoalDetailService.getTextImageForWorst(
                            reducedPercentage: self.miReducedTotalScreenTimePercent,
                            educationIncPercent: self.miEducationalTotalScreenTimePercent
                        )
                        self.miMrArthurImage = image
                        self.miMrArthurMessage = label
                    }
                }
                completion()
            }
        }
        
        private func setData() {
            let (mediationStatus, goalStatus, createDate ,previewDate) = self.getMediationStatus(self.attendee)
            if mediationStatus != self.statusOfMeditation {
                self.iPublicHealthRecommendations = self.attendee.age < 12 ? 60 : 120
                self.publicHealthRecommmendationTime = self.attendee.age < 12
                ? "01h00 / day"
                : "02h00 / day"
                self.statusOfMeditation = mediationStatus
                self.isGoal = goalStatus
                self.createdDateOrUpdatedDateOBD = createDate
                self.previewUpdatedDate = previewDate
                setScreenTimeData()
            }
        }
        
        func setScreenTimeData() {
            if self.isGoal {
                self.setAfterGoalData()
            } else {
                self.setBeforeGoalData()
            }
            self.setChartData()
        }
        
        private func setBeforeGoalData() {
            if let estimation = attendee.attendeeUserMediationList?.last?.stepListJsonb?.estimation {
                self.iSmartPhoneMinutes = estimation.dailyOwnSmartPhoneMinutes ?? 0
                self.iTabletMinutes = estimation.dailyOwnTabletMinutes ?? 0
                self.iEducationalAppMinutes = estimation.dailyEducativeTimeMinutes ?? 0
                self.diagnosedScreenTimeMinutes = estimation.diagnosedScreenTimeMinutes ?? 0
                self.iTotalScreenTimeMinutes = estimation.diagnosedScreenTimeMinutes ?? 0
            }
            
            let (h,m,_) = UtilityMethod.minutesToHoursMinutesSeconds(
                self.diagnosedScreenTimeMinutes
            )
            self.graphScreenTime = self.diagnosedScreenTimeMinutes
            self.avgScreenTime = h.toTimeFormate + "h" + m.toTimeFormate
            
            /// to update frames
            self.fUpdateDailyConsumption += 1
            self.fUpdateBreakActivity += 1
        }
        
        private func setAfterGoalData() {
            if let data = mediationData {
                let (h,m,_) = UtilityMethod.minutesToHoursMinutesSeconds(
                    data.totalTimeMinutes ?? 0
                )
                self.avgScreenTime = h.toTimeFormate + "h" + m.toTimeFormate
                self.iEducationalAppMinutes = data.educativeTimeMinutes ?? 0
                self.iTotalScreenTimeMinutes = data.totalTimeMinutes ?? 0
                self.iSmartPhoneMinutes = data.estimatedSmartPhoneMinutes ?? 0
                self.iTabletMinutes = data.estimatedTabletMinutes ?? 0
                self.graphScreenTime = data.totalTimeMinutes ?? 0
            }
        }
        
        private func setChartData() {
            let redJauger = self.iTotalScreenTimeMinutes
            let blueJauger = self.iEducationalAppMinutes
            let pinkJauger = 480
            let whiteJauger = (16 * 60) - pinkJauger - redJauger
            
            self.iTotalScreeenTime = redJauger
            self.iEducationScreeenTime = blueJauger
            self.iFreeTime = whiteJauger
            self.iSchoolTime = pinkJauger
            
            /// to update frames
            self.updateFrames()
        }
        
        private func setEducationalTime(iEducationalTime: Int) {
            let (h,m,_) = UtilityMethod.minutesToHoursMinutesSeconds(iEducationalTime)
            self.miEducationalTotalScreenTime = h.toTimeFormate + "h" + m.toTimeFormate
        }
        private func setTotalTime(iTotalScreenTime: Int) {
            let (h,m,_) = UtilityMethod.minutesToHoursMinutesSeconds(iTotalScreenTime)
            self.miReducedTotalScreenTime = h.toTimeFormate + "h" + m.toTimeFormate
        }
        private func setActivityData(numberOfSaveMinute: Int) {
            let totalComicValue: Double = Double(numberOfSaveMinute * 365/45)
            let numberOfTotalComic = roundToOneDecimalPlace(totalComicValue)
            let comicTitle = "\(numberOfTotalComic)" + " " + "comics".localized
            self.miComic = comicTitle
            
            let totalRideValue: Double = Double(numberOfSaveMinute * 365/60)
            let noOfTotalRideValue = roundToOneDecimalPlace(totalRideValue)
            let rideTitle = "\(noOfTotalRideValue)" + " " + "miles/\nbike rides".localized
            self.miBikeTrip = rideTitle
            
            let totalAfternoonValue: Double = Double(numberOfSaveMinute * 365/120)
            let totalAfternoon = roundToOneDecimalPlace(totalAfternoonValue)
            let afternoonTitle = "\(totalAfternoon)" + " " + "afternoons".localized
            self.miAfternoon = afternoonTitle
        }
        private func roundToOneDecimalPlace(_ x: Double) -> Int {
            let value = Double(round(1 * x) / 1)
            return Int(value)
        }
        private func getMediationStatus(_ attendee: AttendeeListResponseModel)
        -> (
            mediationStatus: String,
            goalStatus: Bool,
            creatDate: String,
            previewDate: String
        ) {
            var mediationStatus = statusOfMeditation
            var goalStatus = false
            var creatDate = DateService.shared.getDateMonthYearFromNow()
            var previewDate = DateService.shared.getDateMonthYearFromNow()
            if (attendee.attendeeUserMediationList?.last?.stepListJsonb?.list?.count == 0) {
                mediationStatus = ConstantOfApp.kMediationNotCreated
                goalStatus = false
            } else if let statusOfUpdatedmediation = self.attendee.attendeeUserMediationList?
                .last?.stepListJsonb?.list?.last?.accepted as? Bool {
                if(statusOfUpdatedmediation){
                    mediationStatus = ConstantOfApp.kMediationApproved
                    goalStatus = true
                    //createdAt
                    if let date = attendee.attendeeUserMediationList?.last?.stepListJsonb?.list?.last?.updatedAt as? String {
                        creatDate = (UtilityMethod().getViewCreatedAtAndUpdatedDate(dateString: date))
                    }
                } else {
                    mediationStatus = ConstantOfApp.kMediationRejected
                    //Updatedat
                    if let date = attendee.attendeeUserMediationList?.last?.stepListJsonb?.list?.last?.updatedAt as? String {
                        creatDate = (UtilityMethod().getViewCreatedAtAndUpdatedDate(dateString: date))
                    }
                }
            } else {
                mediationStatus = ConstantOfApp.kMediationUnderApproval
                if let date = attendee.attendeeUserMediationList?.last?.stepListJsonb?.list?.last?.createdAt as? String {
                    creatDate = (UtilityMethod().getViewCreatedAtAndUpdatedDate(dateString: date))
                }
                if let date = attendee.attendeeUserMediationList?.last?.stepListJsonb?.list?.last?.updatedAt as? String {
                    previewDate = (UtilityMethod().getViewCreatedAtAndUpdatedDate(dateString: date))
                }
            }
            return (
                mediationStatus: mediationStatus,
                goalStatus: goalStatus,
                creatDate: creatDate,
                previewDate: previewDate
            )
        }
        private func updateFrames() {
            self.fUpdateDailyConsumption += 1
            self.fUpdateBreakActivity += 1
        }
    }
}
