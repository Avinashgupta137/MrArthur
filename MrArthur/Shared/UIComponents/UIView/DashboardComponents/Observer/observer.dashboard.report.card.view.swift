//
//  observer.dashboard.report.card.view.swift
//  MrArthur
//
//  Created by Troo on 29/08/22.
//

import SwiftUI

struct OBSDashboardTodayReportCardView: View {
    @Binding var entertainmentTimeLeft: Int
    @Binding var entertainmentTimeSpent: Int
    @Binding var entertainmentTotalTime: Int
    @Binding var educationalTimeSpent: Int
    @Binding var educationalTotalTime: Int
    
    let onShare: () -> ()
    
    @State var reportTitle: String = EWeekDay.MONDAY.rawValue
    @State var reportSubtitle: String = ""
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
                    Text(reportSubtitle)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                }
                Spacer()
            }
            .padding(.bottom, 10.h)
            
            EntertainmentTimeView(
                icon: "AttendeeDashboardStarSmallYellow",
                label: "Entertainment time left",
                seconds: entertainmentTimeLeft,
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
            .padding(.bottom, 5.h)
            
            AchievementHorizontalView(
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
    }
    
    private func setData() {
        if let value = DateService.shared
            .getWeekDayFromDateString(
                dateString: DateService.shared.getCurrentDate()
            ) {
            self.reportTitle = value.capitalizingFirstLetter()
        }
        
        self.reportSubtitle = DateService.shared
            .getStringDateWithSuffixfromDateString(
                dateString: DateService.shared.getCurrentDate()
            )
            .uppercased()
        
        print("Date Month :\( self.reportSubtitle)")
        let newDate = self.reportSubtitle
        let frenchDateArr : [String] = newDate.components(separatedBy: " ")
        var firstName : String = frenchDateArr[0]
        var secondName : String = frenchDateArr[1]
        let characters = Array(firstName)
        print("Characters: \(characters)")
        let filterDate = firstName.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        print(firstName.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined())
        var frenchDate = ""
        frenchDate.append(filterDate)
        frenchDate.append("\(" ")")
        frenchDate.append(secondName)
        if UtilityMethod.isFrench{
            self.reportSubtitle = frenchDate
        }
    }
}

struct ObserverDashboardReportCardViewPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            OBSDashboardTodayReportCardView(
                entertainmentTimeLeft: .constant(0),
                entertainmentTimeSpent: .constant(0),
                entertainmentTotalTime: .constant(0),
                educationalTimeSpent: .constant(0),
                educationalTotalTime: .constant(0),
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
