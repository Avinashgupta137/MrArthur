//
//  observer.timesaved.screen.benefit.view.swift
//  MrArthur
//
//  Created by Amit Sinha on 15/11/22.
//

import Foundation

extension ObserverTimeSavedScreenBenefitView{
    class OBSBenefitTimeDetailsObserver: ObservableObject {
        let attendee = UserDefaultsHelper.selectedAttendee
        var educationalCommintementTime : Int = 0
        @Published var userName : String = ""
        var entertainmentTotalTime: Int = 0
        
        @Published var todayData: GetAttendeeScreenTimeTodayDataResponse = GetAttendeeScreenTimeTodayDataResponse()
        
        @Published var totalSecondSavedFromBeginning: Int = 0
        init(){
            self.userName = attendee?.attendeeName ?? ""
            if let localAttendee = UserDefaultsHelper.selectedAttendee {
                if let todayDataList = UserDefaultsHelper.screenTimeTodayAttendeeList as ScreenTimeTodayAttendeeListModel? {
                    for data in todayDataList {
                        if (data.attendeeUserUUID == localAttendee.uuid) {
                            self.todayData = data
                            self.setValues()
                        }
                    }
                }
            }
        }
        private func setValues() {
            self.totalSecondSavedFromBeginning = self.todayData.totalSecondSaved
        }
        public func computeTotalTimeSaveFromSecond(second: Int) -> String {
            let (h, m) = (second / 3600, (second % 3600) / 60)
            let minute: String = m < 10 ? "0\(m)" : "\(m)"
            return "\(h)h\(minute)"
        }
    }
}
