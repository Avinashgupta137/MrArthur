//
//  observer.screen.time.dashboard.view.swift
//  MrArthur
//
//  Created by BAPS on 09/11/22.
//

import SwiftUI

struct ObserverScreenTimeDashboardView: View {
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    @StateObject var observer = OBSScreenTimeObserver()
    @State var showAttendeeProfile: Bool = false
    @State var showAttendeeList: Bool = false
    @State var report7DaysTimeLeft: Int = 0
    @State var report30DaysTimeLeft: Int = 0
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack{
                VStack(spacing: 0) {
                    ObserverDashboardUserView(
                        totalSavedSecondScreenTime: $observer.totalSecondSavedFromBeginning,
                        multiDeviceEducationalQuarterReached: $observer.multiDeviceEducationalQuarterReached,
                        attendee: observer.attendee,
                        attendeeProfile: {
                            AmplitudeService.sendEvent(
                                key: .OBS_DASH_TIME_01_START_ATTENDEE_LIST
                            )
                            self.showAttendeeProfile = true
                        }, attendeeList: {
                            AmplitudeService.sendEvent(
                                key: .OBS_DASH_TIME_01_START_ATTENDEE_PROFILE
                            )
                            self.showAttendeeList = true
                        }
                    )
                    .padding(.bottom, 19.h)
                    
                    ObserverDashboardSegementView(selected: $observer.reportOf)
                        .padding(.bottom, 15.h)
                    
                    Group {
                        switch observer.reportOf {
                        case .WEEK:
                            OBSDashboadMultidaysReportCardView(
                                reportOf: $observer.reportOf,
                                entertainmentTimeLeft: $report7DaysTimeLeft,
                                entertainmentTimeSpent: $observer.report7DaysData.entertainmentTimeSpent,
                                entertainmentTotalTime: $observer.report7DaysData.entertainmentScreenTimeSecondAllowed,
                                educationalTimeSpent: $observer.report7DaysData.educationalTimeSpent,
                                educationalTotalTime: $observer.report7DaysData.educationalScreenTimeSecondCommitment,
                                averageScreenTime: $observer.report7DaysData.averageScreenTimePerDay,
                                onShare: {}
                            ).onAppear() {
                                self.report7DaysTimeLeft = observer.reportTimeLeft(
                                    unlocked: observer.report7DaysData.unlockedEntertainmentTime,
                                    spent: observer.report7DaysData.entertainmentTimeSpent
                                )
                            }
                        case .MONTH:
                            OBSDashboadMultidaysReportCardView(
                                reportOf: $observer.reportOf,
                                entertainmentTimeLeft: $report30DaysTimeLeft,
                                entertainmentTimeSpent: $observer.report30DaysData.entertainmentTimeSpent,
                                entertainmentTotalTime: $observer.report30DaysData.entertainmentScreenTimeSecondAllowed,
                                educationalTimeSpent: $observer.report30DaysData.educationalTimeSpent,
                                educationalTotalTime: $observer.report30DaysData.educationalScreenTimeSecondCommitment,
                                averageScreenTime: $observer.report30DaysData.averageScreenTimePerDay,
                                onShare: {}
                            ).onAppear() {
                                self.report30DaysTimeLeft = observer.reportTimeLeft(
                                    unlocked: observer.report30DaysData.unlockedEntertainmentTime,
                                    spent: observer.report30DaysData.entertainmentTimeSpent
                                )
                            }
                        case .TODAY:
                            OBSDashboardTodayReportCardView(
                                entertainmentTimeLeft: $observer.entertainmentTimeLeft,
                                entertainmentTimeSpent: $observer.entertainmentTimeSpent,
                                entertainmentTotalTime: $observer.entertainmentTotalTime,
                                educationalTimeSpent: $observer.educationalTimeSpent,
                                educationalTotalTime: $observer.educationalTotalTime,
                                onShare: {}
                            )
                        }
                        
                    }
                    .padding(.bottom, 16.h)
                    
                    if observer.reportOf == .TODAY {
                        OBSDashboardATTDailyGoalView(
                            educationalQuarterOnGoing: $observer.todayData.multiDeviceEducationalQuarterReached,
                            entertainmentTimeSpent: $observer.todayData.multiDeviceEntertainmentTimeSpent,
                            entertainementTotalTime: $observer.todayData.entertainmentScreenTimeSecondAllowed,
                            educationalTimeSpent: $observer.todayData.multiDeviceEducationalTimeSpent,
                            educationalTotalTime: $observer.todayData.educationalScreenTimeSecondCommitment
                        )
                            .padding(.bottom, 10.h)
                    }
                    
                    ObserverDashboardBenefitView()
                }
                .padding(.bottom, 60.h)
                .onReceive(timer) { _ in
                    if let uuid = observer.attendee.uuid {
                        observer.setScreenTimeTodayData(attendeeUUID: uuid)
                    }
                    
                }
            }
            .padding(.vertical, 16.h)
            .padding(.horizontal, 24.h)
            
            NavigationLink(
                "",
                destination: AttendeeListView(fromDashboard: true),
                isActive: $showAttendeeList
            )
            .labelsHidden()
            NavigationLink(
                "",
                destination: AttendeeProfileDetailView(),
                isActive: $showAttendeeProfile
            )
            .labelsHidden()

        }
        .customNavigationView(
            title: "Dashboard",
            color: .white
        )
        .background(Color.secondaryRed)
        .onAppear {
            observer._init()
            SubscriptionService.setBlockScreenStatus()
        }
    }
}

/*
struct ObserverScreenTimeDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ObserverScreenTimeDashboardView()
            .multiPreview
    }
}*/
