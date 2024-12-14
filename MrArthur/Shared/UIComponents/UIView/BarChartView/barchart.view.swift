//
//  BarChartView.swift
//  MrArthur
//
//  Created by Troo on 25/07/22.
//

import SwiftUI

struct BarChartData {
    var title: String = ""
    var seconds: Int
    var recommendation: Int = 0
    var color: Color = .primaryBlue
    var icon: String
    var hours: String {
        let h = UtilityMethod.secondsToHoursMinutesSeconds(seconds).0
        return "\(h)h"
    }
    var time: String {
        let (h, m, _) = UtilityMethod.secondsToHoursMinutesSeconds(seconds)
        return h.toTimeFormate + "h" + m.toTimeFormate
    }
}

struct BarChartView: View {
    let data: [BarChartData]
    let publicHealthRecommendations: Int
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    let fullBarHeight = geo.size.height * 0.9
                    let maxValue = data.map {$0.seconds}.max()!
                    ForEach(0..<data.count, id: \.self) { i in
                        BarChartCell(
                            data: data[i],
                            maxValue: Double(maxValue),
                            fullBarHeight: fullBarHeight
                        )
                            .padding(.trailing, 8)
                    }
                    
                    BarChartTotalDevicesCell(
                        all: data,
                        fullBarHeight: fullBarHeight,
                        publicHealthRecommendations: publicHealthRecommendations
                    )
                }
            }
        }
        .padding(.horizontal, 10)
        .frame(height: ((UIScreen.screenHeight * 0.4) - 100))
    }
}

struct BarChartTotalDevicesCell: View {
    let all: [BarChartData]
    let fullBarHeight: Double
    let publicHealthRecommendations: Int
    var progressAnimation: Animation {
        Animation
            .linear
            .speed(0.5)
            .delay(0.1)
    }
    
    @State var totalTime: String = "00h00"
    @State var barHeight: CGFloat = 0
    @State var recommendationsBarHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            HStack(spacing: 8) {
                Rectangle()
                    .fill(Color.primaryRed)
                    .frame(width: 1, height: fullBarHeight)
                VStack(spacing: 0){
                    Text(totalTime)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont15
                        )
                        .padding(.vertical, 3)
                        .padding(.horizontal, 10)
                        .background(Color.primaryRed.cornerRadius(68))
                        .padding(.top, 16)
                    Spacer(minLength: 10)
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(Color.primaryRed)
                            .frame(height: barHeight)
                            .animation(self.progressAnimation, value: barHeight)
                        
                        Rectangle()
                            .fill(Color.thirdBlue)
                            .frame(height: min(
                                recommendationsBarHeight,
                                barHeight
                            ))
                            .animation(self.progressAnimation, value: barHeight)
                    }
                    .background(Color.clear)
                    .cornerRadius(width / 2)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 5)
                    
                    Image("DashboardObserverAllDevicesIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                    
                    Text("Total devices".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont10,
                            color: .primaryRed
                        )
                        .padding(.top, 5)
                }
                .frame(height: (fullBarHeight + 140) , alignment: .bottom)
            }
        }
        .onAppear {
            setData()
        }
    }
    
    private func setData() {
        self.barHeight = fullBarHeight
        let totalSeconds = all.map({$0.seconds}).reduce(0, +)
        self.recommendationsBarHeight = (self.fullBarHeight * Double(publicHealthRecommendations)) / Double(totalSeconds)
        self.totalTime = UtilityMethod.secondsToHoursMinutes(totalSeconds)
    }
}

struct BarChartCell: View {
    var data: BarChartData
    var maxValue: Double
    var fullBarHeight: Double
    
    var progressAnimation: Animation {
        Animation
            .linear
            .speed(0.5)
            .delay(0.1)
    }
    
    @State var barHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            VStack(spacing: 0){
                Text(data.time)
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont15
                    )
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .background(Color.primaryBlue.cornerRadius(68))
                    .padding(.top, 16)
                Spacer(minLength: 10)
                Rectangle()
                    .fill(Color.primaryBlue)
                    .frame(height: barHeight)
                    .cornerRadius(width / 2)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 5)
                    .animation(self.progressAnimation, value: barHeight)
                
                Image(data.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                
                Text(data.title)
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont10,
                        color: .primaryBlue
                    )
                    .padding(.top, 5)
            }
            .frame(height: (fullBarHeight + 140) , alignment: .bottom)
        }
        .onAppear {
            self.barHeight = (Double(fullBarHeight) / maxValue) * Double(data.seconds)
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(
            data: [
                BarChartData(
                    title: "CUSTOM_SMARTPHONE".localized,
                    seconds: 20000,
                    icon: "iconSmartphone"
                ),
                BarChartData(
                    title: "Tablet".localized,
                    seconds: 15000,
                    icon: "GameConsol"
                ),
                BarChartData(
                    title: "Tablet".localized,
                    seconds: 11110,
                    icon: "iconPad"
                ),
            ],
            publicHealthRecommendations: 10000
            
        )
            .frame(height: UIScreen.screenHeight * (isiPad() ? 0.45 : 0.43), alignment: .top)
            .padding(.horizontal, 16)
            .background(Color.green)
    }
}
