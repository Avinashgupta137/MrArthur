//
//  CircularGraphView.swift
//  MrArthur
//
//  Created by Troo on 22/07/22.
//

import SwiftUI

private enum ChartDataType: String {
    case totalTime = "Total screen time"
    case educationTime = "Educational screen time"
    case freeTime = "Free time"
    case schoolTime = "School time"
    case none = "None"
}

struct CircularChartView : View {
    
    let totalScreeenTime: Int
    let educationScreeenTime: Int
    let freeTime: Int
    let schoolTime: Int
    let lineWidth: CGFloat = 35.r
    let eduLineWidth: CGFloat = 35.r / 2
    
    @State var totalHours = "0"
    @State var sTotalScreeenTime: CGFloat = 0
    @State var sEducationScreeenTime: CGFloat = 0
    @State var sFreeScreeenTime: CGFloat = 0
    @State var sSchoolScreeenTime: CGFloat = 0
    
    var body: some View {
        VStack{
            ZStack {
                //MARK: - Total Screen Time
                Circle()
                    .trim(
                        from: 0,
                        to: sTotalScreeenTime
                    )
                    .stroke(
                        Color.forthRed,
                        lineWidth: lineWidth
                    )
                    .rotationEffect(.degrees(90))
                    .animation(.spring(), value: sTotalScreeenTime)
                
                //MARK: - Educational Screen Time
                Circle()
                    .trim(
                        from: 0,
                        to: sEducationScreeenTime
                    )
                    .stroke(
                        Color.primaryBlue,
                        lineWidth: eduLineWidth
                    )
                    .rotationEffect(.degrees(90))
                    .animation(.spring(), value: sTotalScreeenTime)
                    .padding(-(eduLineWidth/2))
                
                //MARK: - Free Time
                Circle()
                    .trim(
                        from: sTotalScreeenTime,
                        to: sFreeScreeenTime
                    )
                    .stroke(
                        Color.white,
                        lineWidth: lineWidth
                    )
                    .rotationEffect(.degrees(90))
                    .animation(.spring(), value: sFreeScreeenTime)
                
                //MARK: - School Time
                Circle()
                    .trim(
                        from: sFreeScreeenTime,
                        to: sSchoolScreeenTime
                    )
                    .stroke(
                        Color.lightPink,
                        lineWidth: lineWidth
                    )
                    .rotationEffect(.degrees(90))
                    .animation(.spring(), value: sSchoolScreeenTime)
                
                VStack(spacing: 8.h) {
                    Image("iconAwakeTime")
                        .resizable()
                        .frame(
                            width: 50.r,
                            height: 50.r
                        )
                    Text(totalHours)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont18,
                            color: .primaryBlue
                        )
                    +
                    Text("h")
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .primaryBlue
                        )
                }
            }
            .frame(
                width: 185.r,
                height: 185.r
            )
            .padding(34.r)
            
            HStack(spacing: 10.w) {
                ChartTimeView(
                    value: totalScreeenTime,
                    fColor: .white,
                    bColor: .forthRed,
                    label: ChartDataType.totalTime.rawValue
                )
                
                ChartTimeView(
                    value: educationScreeenTime,
                    fColor: .white,
                    bColor: .primaryBlue,
                    label: ChartDataType.educationTime.rawValue
                )
                
                ChartTimeView(
                    value: freeTime,
                    fColor: .primaryBlue,
                    bColor: .white,
                    label: ChartDataType.freeTime.rawValue
                )
                ChartTimeView(
                    value: schoolTime,
                    fColor: .primaryBlue,
                    bColor: .lightPink,
                    label: ChartDataType.schoolTime.rawValue
                )
            }
        }
        .onAppear() {
            setValues()
        }
    }
    
    private func setValues() {
        let totalMinutes = totalScreeenTime + freeTime + schoolTime
        
        let (h,_,_) = UtilityMethod.minutesToHoursMinutesSeconds(totalMinutes)
        self.totalHours = "\(h) "
        if totalMinutes > 0 {
            let tempTotalScreenTime = CGFloat(
                (totalScreeenTime * 100) / totalMinutes
            ) / 100
            sTotalScreeenTime = (tempTotalScreenTime * 100)
                .rounded(.up) / 100
            
            let tempEducationScreeenTime = CGFloat(
                (educationScreeenTime * 100) / totalMinutes
            ) / 100
            sEducationScreeenTime = (tempEducationScreeenTime * 100)
                .rounded(.up) / 100
            
            let tempFreeTime = CGFloat(
                (freeTime * 100) / totalMinutes
            ) / 100
            sFreeScreeenTime = ((tempFreeTime * 100)
                .rounded(.up) / 100) + sTotalScreeenTime
            
            let tempSchoolTime = CGFloat(
                (schoolTime * 100) / totalMinutes
            ) / 100
            sSchoolScreeenTime = (((tempSchoolTime * 100)
                .rounded(.up) / 100) + sFreeScreeenTime).rounded()
        }
    }
}

private struct ChartTimeView: View {
    let value: Int
    let fColor: Color
    let bColor: Color
    let label: String
    
    @State var vLabel = ""
    var body: some View {
        VStack(spacing: 10.h) {
            Text(vLabel)
                .fontModifier(
                    font: .montserratBold,
                    size: iPhoneFont18,
                    color: fColor
                )
                .padding(.vertical, 5.h)
                .frame(
                    width: 86.w
                )
                .background(bColor.cornerRadius(68.r))
            
            Text(label.localized)
                .fontModifier(
                    font: .montserratBold,
                    size: 12,
                    color: .primaryBlue
                )
                .multilineTextAlignment(.center)
                .frame(
                    width: 86.w,
                    height: 100.h,
                    alignment: .top
                )
        }
        .onAppear {
            let (h, m, _) = UtilityMethod.minutesToHoursMinutesSeconds(value)
            vLabel = h.toTimeFormate + "h" + m.toTimeFormate
        }
    }
}

struct CircularChartView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Spacer()
            CircularChartView(
                totalScreeenTime: 1000,
                educationScreeenTime: 240,
                freeTime: 300,
                schoolTime: 600
            )
            Spacer()
        }
        .fullScreenFrame
        .background(Color.secondaryRed)
        .multiPreview
    }
}


