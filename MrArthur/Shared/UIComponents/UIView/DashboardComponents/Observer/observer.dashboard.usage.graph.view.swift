//
//  observer.dashboard.usage.graph.view.swift
//  MrArthur
//
//  Created by trootech on 13/09/22.
//

import SwiftUI

struct OBSDashboardUsageGraphView: View {
    let smartPhoneMinutes: Int
    let tabletMinutes: Int
    let publicHealthRecommendations: Int
    let diagnosedScreenTime : Int
    var totalTime: Int = 480
    let color: Color
    var body: some View {
        VStack(spacing: 0) {
            UsageView(
                icon: "iconSmartphone",
                label: "Smartphone".localized,
                time: smartPhoneMinutes,
                color: color,
                totalTime: totalTime
            )
            .padding(.bottom, 24.h)
            
            UsageView(
                icon: "iconPad",
                label: "Tablet".localized,
                time: tabletMinutes,
                color: color,
                totalTime: totalTime
            )
            .padding(.bottom, 40.h)
            
            Rectangle()
                .fill(Color.white)
                .frame(height: 1.r)
                .padding(.leading, 60.w)
                .padding(.trailing, 100.w)
                .padding(.bottom, 24.h)
            
            TotalUsageView(
                icon: "iconiPadiPhone",
                label: "Total".localized,
                time: diagnosedScreenTime,
                publicHealthRecommendations: publicHealthRecommendations,
                totalTime: totalTime,
                color: color
            )
        }
    }
}

private struct UsageView: View {
    let icon: String
    let label: String
    let time: Int
    let color: Color
    let totalTime: Int
    @State var timeString = "00h00"
    var body: some View {
        HStack(spacing: 0) {
            
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(
                    width: icon == "iconSmartphone" ? 22.w : 35.w,
                    height: icon == "iconSmartphone" ? 35.h : 35.h
                )
                .padding(.trailing, icon == "iconSmartphone" ? 20.w : 13.w)
                .padding(.leading, icon == "iconSmartphone" ? 5.w : 0)
            
            UsageBarView(
                timeSpent: time,
                totalTime: totalTime,
                color: color,
                fHeight: 50
            )
            
            VStack(spacing: 5.h) {
                Text(label)
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont10,
                        color: .primaryBlue
                    )
                Text(timeString)
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont15
                    )
                    .padding(.vertical, 3.h)
                    .padding(.horizontal, 10.w)
                    .background(color.cornerRadius(24.r))
            }
            .frame(width: 80.w)
            .padding(.leading, 16.h)
        }
        .onAppear {
            let (h,m,_) = UtilityMethod
                .minutesToHoursMinutesSeconds(time)
            self.timeString = h.toTimeFormate
            + "h"
            + m.toTimeFormate
        }
    }
}

private struct UsageBarView: View {
    let timeSpent: Int
    let totalTime: Int
    let color: Color
    var fHeight: CGFloat = 40
    
    @State var sTimeSpent: CGFloat = 0
    @State var sTimeRemaining: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0){
                Rectangle()
                    .fill(color)
                    .frame(
                        width: min(
                            geometry.size.width * (self.sTimeSpent),
                            geometry.size.width
                        )
                    )
                    .animation(.linear, value: self.sTimeSpent)
                Rectangle()
                    .fill(Color.progressGray)
                    .frame(
                        width: min(
                            geometry.size.width * (self.sTimeRemaining),
                            geometry.size.width
                        )
                    )
                    .animation(.linear, value: self.sTimeRemaining)
                
            }
            .frame(width: geometry.size.width)
            .cornerRadius(fHeight.h/2, corners: [.topLeft, .bottomLeft])
        }
        .frame(height: fHeight.h)
        .padding(5)
        .background(
            Rectangle()
                .fill(Color.white)
                .cornerRadius(fHeight.h/2, corners: [.topLeft, .bottomLeft])
        )
        .onAppear {
            setValues()
        }
        
    }
    
    private func setValues() {
        sTimeSpent = CGFloat((timeSpent * 100) / totalTime) / 100
        if (sTimeSpent < 1) {
            sTimeRemaining = 1 - sTimeSpent
        } else {
            sTimeRemaining = 0
        }
    }
}

private struct TotalUsageView: View {
    let icon: String
    let label: String
    let time: Int
    let publicHealthRecommendations: Int
    let totalTime: Int
    let color: Color
    
    @State var timeString = "00h00"
    var body: some View {
        HStack(spacing: 0) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(
                    width: 44.w,
                    height: 46.h
                )
                .padding(.trailing, 8.w)
            
            TotalUsageBarView(
                timeSpent: time,
                totalTime: totalTime,
                publicHealthRecommendations: publicHealthRecommendations,
                color: color,
                fHeight: 50
            )
            
            VStack(spacing: 5.h) {
                Text(label)
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont10,
                        color: .primaryBlue
                    )
                Text(timeString)
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont15
                    )
                    .padding(.vertical, 3.h)
                    .padding(.horizontal, 10.w)
                    .background(color.cornerRadius(24.r))
            }
            .frame(width: 80.w)
            .padding(.leading, 16.h)
        }
        .onAppear {
            let (h,m,_) = UtilityMethod
                .minutesToHoursMinutesSeconds(time)
            self.timeString = h.toTimeFormate
            + "h"
            + m.toTimeFormate
        }
    }
}

private struct TotalUsageBarView: View {
    let timeSpent: Int
    let totalTime: Int
    let publicHealthRecommendations: Int
    let color: Color
    var fHeight: CGFloat = 40
    
    @State var sTimeSpent: CGFloat = 0
    @State var sTimeRemaining: CGFloat = 0
    @State var sRecommendations: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            ZStack(alignment: .leading) {
                HStack(spacing: 0){
                    Rectangle()
                        .fill(color)
                        .frame(
                            width: min(
                                width * (self.sTimeSpent),
                                width
                            )
                        )
                        .animation(.linear, value: self.sTimeSpent)
                    Rectangle()
                        .fill(Color.progressGray)
                        .frame(
                            width: min(
                                width * (self.sTimeRemaining),
                                width
                            )
                        )
                        .animation(.linear, value: self.sTimeRemaining)
                    
                }
                .frame(width: abs(geometry.size.width - 10), height: fHeight.h)
                .cornerRadius(fHeight.h/2, corners: [.topLeft, .bottomLeft])
                .padding(5)
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(fHeight.h/2, corners: [.topLeft, .bottomLeft])
                )
                Rectangle()
                    .fill(Color.thirdBlue)
                    .frame(
                        width: timeSpent > 0 ? 8.w : 0,
                        height: (fHeight + 32).h
                    )
                    .cornerRadius(25)
                    .padding(.leading, min(
                        width * (self.sRecommendations),
                        width
                    ))
                    .animation(.linear, value: self.sRecommendations)
            }
        }
        .frame(height: (fHeight + 32).h)
        .onAppear {
            setValues()
        }
        
    }
    
    private func setValues() {
        sRecommendations = CGFloat((publicHealthRecommendations * 100) / totalTime) / 100
        sTimeSpent = CGFloat((timeSpent * 100) / totalTime) / 100
        if (sTimeSpent < 1) {
            sTimeRemaining = 1 - sTimeSpent
        } else {
            sTimeRemaining = 0
        }
    }
}

struct OBSDashboardUsageGraphViewPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            OBSDashboardUsageGraphView(
                smartPhoneMinutes: 0,
                tabletMinutes: 0,
                publicHealthRecommendations: 0,
                diagnosedScreenTime: 0,
                color: .validateGreen
            )
            .padding(.horizontal, 16)
            Spacer()
        }
        .background(Color.lightPink)
        .multiPreview
    }
}
