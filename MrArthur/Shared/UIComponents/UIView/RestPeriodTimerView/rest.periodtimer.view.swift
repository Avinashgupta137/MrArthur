//
//  rest.period.view.swift
//  MrArthur
//
//  Created by IPS-157 on 31/08/22.
//

import SwiftUI

struct RestPeriodTimerView: View {
    var contentImage : String
    var timerLabel : String
    let isActiveTimer: Bool
    let isBorder: Bool
    let onTap: ()->()
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack(spacing: 16.iPadIncBy_15){
                Image(contentImage)
                    .resizable()
                    .frame(
                        width: 50.iPadIncBy_25,
                        height: 50.iPadIncBy_25
                    )
                Text(timerLabel.localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont25,
                        color: .primaryBlue
                    )
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }
        .padding(20.iPadIncBy_25)
        .background(
            Group{
                if isActiveTimer {
                    Color.white.cornerRadius(27)
                } else{
                    Color.white.cornerRadius(27)
                }
            }
        )

        .overlay(
            RoundedRectangle(
                cornerRadius: 28.r
            )
            .inset(by: 1)
            .stroke(Color.validateGreen, lineWidth: 3.h)
            .opacity(isBorder ? 1 : 0)
        )
        .contentShape(Rectangle())
        .cornerRadius(16.iPadIncBy_15)
    }
}

struct RestPeriodTimerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            RestPeriodTimerView(
                contentImage: "SettingsFilteringTime04",
                timerLabel: "No rest period",
                isActiveTimer: true,
                isBorder: true,
                onTap: {}
            )
            Spacer()
        }
        .padding(30)
        .fullScreenFrame
        .background(Color.forthRed)
    }
}

