//
//  time.view.swift
//  MrArthur
//
//  Created by Troo on 29/08/22.
//

import SwiftUI

struct EntertainmentTimeView: View {
    let icon: String
    let label: String
    let seconds: Int
    let backgroundColor: Color
    var body: some View {
        HStack(spacing: 12.w) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 28.r, height: 28.r)
            
            HStack(spacing: 0) {
                
                Text(label.localized)
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont12
                    )
                
                Spacer()
                
                Text(getTimeBySeconds())
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont15
                    )
            }
            .padding(.horizontal, 14.w)
            .frame(height: 31.h)
            .background(backgroundColor.cornerRadius(17.r))
        }
    }
    
    private func getTimeBySeconds() -> String {
        let (h, m, s) = UtilityMethod.secondsToHoursMinutesSeconds(self.seconds)
        if (h < 0 || m < 0 || s < 0) {
            return "-" + abs(h).toTimeFormate + ":" + abs(m).toTimeFormate + ":" + abs(s).toTimeFormate
        } else {
            return h.toTimeFormate + ":" + m.toTimeFormate + ":" + s.toTimeFormate
        }
    }
}

struct EntertainmentTimeViewPreviews: PreviewProvider {
    static var previews: some View {
        VStack{
            EntertainmentTimeView(
                icon: "GameConsol",
                label: "Entertainment time left".localized,
                seconds: 60,
                backgroundColor: .primaryYellow
            )
            EntertainmentTimeView(
                icon: "GameConsol",
                label: "Entertainment time spent".localized,
                seconds: 125,
                backgroundColor: .primaryRed
            )
        }
        .padding(.horizontal, 24.h)
    }
}
