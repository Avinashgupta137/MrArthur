//
//  achievement.horizontal.view.swift
//  MrArthur
//
//  Created by Troo on 29/08/22.
//

import SwiftUI

struct AchievementHorizontalView: View {
    
    @Binding var educationalTimeSpent: Int
    @Binding var totalEducationalTime: Int
    @Binding var totalEntertainmentTime: Int
    
    @State var sTimeSpent: CGFloat = 0
    @State var sTimeRemaining: CGFloat = 0
    
    @State var achievementValueSpacing: CGFloat = 0
    @State var achievementValue: String = ""
    
    @State var textSize: CGSize = .zero
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geometry in
                HStack(spacing: 0){
                    Rectangle()
                        .fill(Color.primaryBlue)
                        .frame(
                            width: min(
                                geometry.size.width * (self.sTimeSpent),
                                geometry.size.width
                            )
                        )
                        .animation(.linear, value: sTimeSpent)
                    
                    Rectangle()
                        .fill(Color.progressGray)
                        .frame(
                            width: min(
                                geometry.size.width * (self.sTimeRemaining),
                                geometry.size.width
                            )
                        )
                        .animation(.linear, value: sTimeRemaining)
                }
            }
            .frame(height: 40.h)
            .cornerRadius(24.r, corners: [.topLeft, .bottomLeft])
            .padding(5.r)
            .background(
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(
                        24.r,
                        corners: [.topLeft, .bottomLeft]
                    )
                    .shadow(radius: 6, x: 0, y: 3)
            )
            
            
            HStack(spacing:0) {
                Spacer()
                AchievementMilestoneView(
                    completed: sTimeSpent >= 0.25
                )
                Spacer()
                AchievementMilestoneView(
                    completed: sTimeSpent >= 0.5
                )
                Spacer()
                AchievementMilestoneView(
                    completed: sTimeSpent >= 0.75
                )
                Spacer()
                AchievementMilestoneView(
                    completed: sTimeSpent >= 1,
                    icon: "AttendeeDashboardCupSmall",
                    width: 0
                )
            }
            .padding(.leading, 10.w)
            
            if achievementValueSpacing > 0 {
                GeometryReader { geometry in
                    Text(achievementValue)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont10,
                            color: .primaryYellow
                        )
                        .background(ViewGeometry())
                        .onPreferenceChange(ViewSizeKey.self) {
                            textSize = $0
                        }
                        .padding(.top, 85.h)
                        .padding(
                            .leading,
                            (
                                geometry.size.width
                                * achievementValueSpacing
                            )
                            - (textSize.width / 2)
                        )
                }
                .frame(height: 100.h)
                .clipped()
            }
        }
        .onAppear {
            setValues()
        }
        .onChange(of: educationalTimeSpent) { _ in
            setValues()
        }
        .onChange(of: totalEducationalTime) { _ in
            setValues()
        }
        .onChange(of: totalEntertainmentTime) { _ in
            setValues()
        }
    }
    
    private func getEntertainmentQuarter() -> QuartersFromSecondModel {
        return ExtensionScreenTimeHelperService.getQuartersFromSecond(second: totalEntertainmentTime)
    }
    
    private func setValues() {
            if educationalTimeSpent > 0 && totalEducationalTime > 0 && totalEntertainmentTime > 0 {
                sTimeSpent = CGFloat((educationalTimeSpent * 100) / totalEducationalTime) / 100
                if (sTimeSpent < 1) {
//                    let quarters: QuartersFromSecondModel = getEntertainmentQuarter()
                    let quarters: QuartersFromSecondModel = ExtensionScreenTimeHelperService.getQuartersFromSecond(
                        second: totalEntertainmentTime
                    )
                    let achievmentValue075: Int = Int(floor(Double(quarters.quarter1 + quarters.quarter2 + quarters.quarter3) / 60))
                    let achiementValue050: Int = Int(floor(Double(quarters.quarter1 + quarters.quarter2) / 60))
                    let achievmentValue025: Int = Int(floor(Double(quarters.quarter1) / 60))
                    sTimeRemaining = 1 - sTimeSpent

                    if sTimeSpent >= 0.75 {
                        achievementValueSpacing = 0.75
                        achievementValue = "+\(achievmentValue075) min"
                    } else if sTimeSpent >= 0.5 {
                        achievementValueSpacing = 0.5
                        achievementValue = "+\(achiementValue050) min"
                    } else if sTimeSpent >= 0.25 {
                        achievementValueSpacing = 0.25
                        achievementValue = "+\(achievmentValue025) min"
                    } else {
                        achievementValue = ""
                    }

                } else {
                    sTimeRemaining = 1
                    achievementValueSpacing = 0
                    achievementValue = ""
                }
            } else {
                sTimeSpent = 0
                sTimeRemaining = 1
                achievementValueSpacing = 0
                achievementValue = ""
            }
        }
}

private struct AchievementMilestoneView: View {
    let completed: Bool
    var icon: String = "AttendeeDashboardStarSmall"
    var width: CGFloat = 5
    var body: some View {
        VStack(spacing: 10) {
            Rectangle()
                .fill(
                    completed
                    ? Color.primaryYellow 
                    : Color.white
                )
                .frame(width: width, height: 50.h)
            
            Image(
                completed
                ? icon + "Yellow"
                : icon + "Blue"
            )
                .frame(width: 15, height: 15)
                .foregroundColor(
                    completed
                    ? .primaryYellow
                    : .primaryBlue
                )
            
        }
    }
}

struct AchievementHorizontalViewPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            AchievementHorizontalView(
                educationalTimeSpent: .constant(60),
                totalEducationalTime: .constant(100),
                totalEntertainmentTime: .constant(100)
            )
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}
