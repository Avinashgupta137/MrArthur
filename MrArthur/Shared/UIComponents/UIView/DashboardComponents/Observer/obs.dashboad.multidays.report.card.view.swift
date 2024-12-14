//
//  obs.dashboad.multidays.report.card.view.swift
//  MrArthur
//
//  Created by BAPS on 15/11/22.
//

import SwiftUI

struct OBSDashboadMultidaysReportCardView: View {
    
    @Binding var reportOf: EDuration
    @Binding var entertainmentTimeLeft: Int
    @Binding var entertainmentTimeSpent: Int
    @Binding var entertainmentTotalTime: Int
    @Binding var educationalTimeSpent: Int
    @Binding var educationalTotalTime: Int
    @Binding var averageScreenTime: Int
    let onShare: () -> ()
    @State var reportTitle: String = "Last 7 days"
    @State var reportAvgScreenTime: String = "00h00"
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(reportTitle)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    Text("USAGE REPORT".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                }
                Spacer()
            }
            .padding(.bottom, 10.h)
            
            HStack(spacing: 0){
                HStack(spacing: 0) {
                    Text("Average screen time per day".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont13,
                            color: .primaryBlue
                        )
                        .padding(.trailing, 16.w)
                    
                    Text(reportAvgScreenTime)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont18,
                            color: .primaryBlue
                        )
                }
                .padding(.vertical, 5.h)
                .padding(.horizontal, 10.w)
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(25.r)
                        .shadow(radius: 6.r, x: 0, y: 3.r)
                )
                
                Spacer(minLength: 16.w)
            }
            .padding(.bottom, 25.h)
            
            EntertainmentTimeView(
                icon: "AttendeeDashboardStarSmallYellow",
                label: "Entertainment time left",
                seconds:  entertainmentTimeLeft,
                backgroundColor: .primaryYellow
            )
            .padding(.bottom, 5.h)
            
            EntertainmentTimeView(
                icon: "DashboardSEntertainmentTimeSpentIcon1",
                label: "Entertainment time spent",
                seconds: entertainmentTimeSpent,
                backgroundColor: .primaryRed
            )
            .padding(.bottom, 12.h)
            
            VStack(alignment: .trailing, spacing: 5.h) {
                HStack(alignment: .bottom, spacing: 5.w) {
                    Text(
                        UtilityMethod.getTimeStringBySeconds(
                            value: entertainmentTotalTime
                        )
                    )
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont10,
                            color: .primaryRed
                    )
                    Image("DashboardSEntertainmentTimeSpentIcon2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15.r, height: 15.r)
                }
                ProgressHorizontalView(
                    timeLeft: $entertainmentTimeLeft,
                    timeSpent: $entertainmentTimeSpent,
                    totalTime: $entertainmentTotalTime
                )
            }
            .padding(.bottom, 30.h)
            
            VStack(alignment: .trailing, spacing: 5.h) {
                EntertainmentTimeView(
                    icon: "DashboardSEducationalTimeSpentIcon1",
                    label: "Educational time spent".localized,
                    seconds: educationalTimeSpent,
                    backgroundColor: .primaryBlue
                )
                HStack(alignment: .bottom, spacing: 5.w) {
                    Text(
                        UtilityMethod.getTimeStringBySeconds(
                            value: educationalTotalTime
                        )
                    )
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont10,
                            color: .primaryBlue
                    )
                    Image("DashboardSEducationalTimeSpentIcon2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15.r, height: 15.r)
                }
            }
            .padding(.bottom, 5)
            
            AchievementMultidayHorizontalView(
                educationalTimeSpent: $educationalTimeSpent,
                totalEducationalTime: $educationalTotalTime,
                totalEntertainmentTime: $entertainmentTotalTime
            )
            
        }
        .padding(24.r)
        .background(Color.white.cornerRadius(22.r))
        .onAppear {
            setData()
        }
        .onChange(of: reportOf) { _ in
            setData()
        }
    }
    
    private func setData() {
        let (h, m, _) = UtilityMethod.secondsToHoursMinutesSeconds(averageScreenTime)
        self.reportAvgScreenTime = h.toTimeFormate + "h" + m.toTimeFormate
        switch reportOf {
        case .TODAY:
            break;
        case .WEEK:
            setWeekData()
        case .MONTH:
            setMonthData()
        }
    }
    
    private func setWeekData() {
        self.reportTitle = "Last 7 days".localized
    }
    
    private func setMonthData() {
        self.reportTitle = "Last 30 days".localized
    }
}

struct OBSDashboadMultidaysReportCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            OBSDashboadMultidaysReportCardView(
                reportOf: .constant(.WEEK),
                entertainmentTimeLeft: .constant(20),
                entertainmentTimeSpent: .constant(30),
                entertainmentTotalTime: .constant(100),
                educationalTimeSpent: .constant(45),
                educationalTotalTime: .constant(100),
                averageScreenTime: .constant(1000),
                onShare: {}
            )
                .padding([.horizontal, .bottom], 16)
            Spacer()
        }
        .customNavigationView(
            title: "Dashboard",
            color: .white
        )
        .background(Color.secondaryRed)
    }
}
