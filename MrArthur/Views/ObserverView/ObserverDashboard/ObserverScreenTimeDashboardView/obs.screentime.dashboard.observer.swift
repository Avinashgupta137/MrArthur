//
//  obs.screentime.dashboard.observer.swift
//  MrArthur
//
//  Created by BAPS on 11/11/22.
//

import Foundation

extension ObserverScreenTimeDashboardView {
    class OBSScreenTimeObserver: ObservableObject {
        
        @Published var attendee: AttendeeListResponseModel = AttendeeListResponseModel()
        @Published var reportOf: EDuration = .TODAY
        @Published var todayData: GetAttendeeScreenTimeTodayDataResponse = GetAttendeeScreenTimeTodayDataResponse()
        
        @Published var report7DaysData: GetAttendeeScreenTimeReportDataResponse = GetAttendeeScreenTimeReportDataResponse(
            attendeeUserUUID: "",
            educationalTimeSpent: 0,
            entertainmentTimeSpent: 0,
            entertainmentScreenTimeSecondAllowed: 0,
            educationalScreenTimeSecondCommitment: 0,
            unlockedEntertainmentTime: 0,
            averageScreenTimePerDay: 0
        )
        
        @Published var report30DaysData: GetAttendeeScreenTimeReportDataResponse = GetAttendeeScreenTimeReportDataResponse(
            attendeeUserUUID: "",
            educationalTimeSpent: 0,
            entertainmentTimeSpent: 0,
            entertainmentScreenTimeSecondAllowed: 0,
            educationalScreenTimeSecondCommitment: 0,
            unlockedEntertainmentTime: 0,
            averageScreenTimePerDay: 0
        )
        
        @Published var entertainmentTimeLeft: Int = 0
        @Published var entertainmentTimeSpent: Int = 0
        @Published var entertainmentTotalTime: Int = 0
        @Published var educationalTimeSpent: Int = 0
        @Published var educationalTotalTime: Int = 0
        @Published var multiDeviceEducationalQuarterReached: Int = 0
        @Published var totalSecondSavedFromBeginning: Int = 0

        func _init() {
            if let localAttendee = UserDefaultsHelper.selectedAttendee {
                // screen time today data
                if let todayDataList = UserDefaultsHelper.screenTimeTodayAttendeeList as ScreenTimeTodayAttendeeListModel? {
                    for data in todayDataList {
                        if (data.attendeeUserUUID == localAttendee.uuid) {
                            self.todayData = data
                            self.setValues()
                        }
                    }
                }
                self.attendee = localAttendee
                self.getDataFromServer()
            } else {
                self.getDataFromServer()
            }
        }
        
        private func getDataFromServer() {
            AttendeeService.shared.getAttendeeByUUID { error, attendee in
                if let attendee = attendee {
                    self.attendee = attendee
                    self.setScreenTimeTodayData(attendeeUUID: attendee.uuid)
                    self.setScreenTimeReportData7Days(attendeeUUID: attendee.uuid)
                    self.setScreenTimeReportData30Days(attendeeUUID: attendee.uuid)
                }
            }
        }
        
        public func setScreenTimeTodayData(attendeeUUID: String?) -> Void {
            if let uuid = attendeeUUID {
                ExtensionApiCallService.getAttendeeScreenTimeTodayData(attendeeUserUUID: uuid) { data in
                    if let data = data {
                        if var todayDataList = UserDefaultsHelper.screenTimeTodayAttendeeList as ScreenTimeTodayAttendeeListModel? {
                            var uuidIsInList: Bool = false
                            for (index, item) in todayDataList.enumerated() {
                                if (item.attendeeUserUUID == uuid) {
                                    todayDataList[index] = data
                                    uuidIsInList = true
                                    break
                                }
                            }
                            if (!uuidIsInList) {
                                todayDataList.append(data)
                            }
                            UserDefaultsHelper.screenTimeTodayAttendeeList = todayDataList
                            DispatchQueue.main.async {
                                self.todayData = data
                                self.setValues()
                            }
//                            print("CurrentTodayAttendeeList")
//                            dump(UserDefaultsHelper.screenTimeTodayAttendeeList)
                        }
                    }
                }
            }
        }
        
        public func setScreenTimeReportData7Days(attendeeUUID: String?) -> Void {
            if let uuid = attendeeUUID {
                ExtensionApiCallService.getAttendeeScreenTimeReportData(attendeeUserUUID: uuid, numberOfDay: 7) { data in
                    if let data = data {
                        if var report7DaysList = UserDefaultsHelper.screenTimeReport7DaysAttendeeList as ScreenTimeReportAttendeeListModel? {
                            var uuidIsInList: Bool = false
                            for (index, item) in report7DaysList.enumerated() {
                                if (item.attendeeUserUUID == uuid) {
                                    report7DaysList[index] = data
                                    uuidIsInList = true
                                    break
                                }
                            }
                            if (!uuidIsInList) {
                                report7DaysList.append(data)
                            }
                            UserDefaultsHelper.screenTimeReport7DaysAttendeeList = report7DaysList
                            DispatchQueue.main.async {
                                self.report7DaysData = data
                            }
                            print("CurrentReport7DaysAttendeeList")
                            dump(UserDefaultsHelper.screenTimeReport7DaysAttendeeList)
                        }
                    }
                }
            }
        }
        
        public func setScreenTimeReportData30Days(attendeeUUID: String?) -> Void {
            if let uuid = attendeeUUID {
                ExtensionApiCallService.getAttendeeScreenTimeReportData(attendeeUserUUID: uuid, numberOfDay: 30) { data in
                    if let data = data {
                        if var report30DaysList = UserDefaultsHelper.screenTimeReport30DaysAttendeeList as ScreenTimeReportAttendeeListModel? {
                            var uuidIsInList: Bool = false
                            for (index, item) in report30DaysList.enumerated() {
                                if (item.attendeeUserUUID == uuid) {
                                    report30DaysList[index] = data
                                    uuidIsInList = true
                                    break
                                }
                            }
                            if (!uuidIsInList) {
                                report30DaysList.append(data)
                            }
                            UserDefaultsHelper.screenTimeReport30DaysAttendeeList = report30DaysList
                            DispatchQueue.main.async {
                                self.report30DaysData = data
                            }
                            print("CurrentReport30DaysAttendeeList")
                            dump(UserDefaultsHelper.screenTimeReport30DaysAttendeeList)
                        }
                    }
                }
            }
        }
        
        
        public func reportTimeLeft(unlocked: Int, spent: Int) -> Int {
            return unlocked - spent
        }
        
        private func setValues() {
            self.entertainmentTimeLeft = (self.todayData.unlockedTime - self.todayData.entTimeSpent)
            self.entertainmentTimeSpent = self.todayData.entTimeSpent
            self.entertainmentTotalTime = self.todayData.entScreenTimeSecondAllowed
            self.educationalTimeSpent = self.todayData.eduTimeSpent
            self.educationalTotalTime = self.todayData.eduScreenTimeSecondCommitment
            self.multiDeviceEducationalQuarterReached = self.todayData.eduQuarterReached
            self.totalSecondSavedFromBeginning = self.todayData.totalSecondSaved
            
        }
    }
}
