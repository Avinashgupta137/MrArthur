//
//  attendee.setting.view.swift
//  MrArthur
//
//  Created by Amit Sinha on 03/11/22.
//

import SwiftUI

struct AttendeeSettingsView: View {
    @State var showParenLogin = false
    @Binding var shouldPopToRootView : Bool
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Settings".localized)
                .fontModifier(
                    font: .montserratBold,
                    size: iPhoneFont25,
                    color: .primaryBlue
                )
            Text("Only your parents are allowed to change your settings.\nPlease ask them to achieve this task.".localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont18,
                    color: .primaryBlue
                )
                .padding(.top, 16.h)
            Spacer(minLength: 16.h)
            HStack(spacing: 0){
                Spacer(minLength: 16.w)
                
                BlueRoundedButton("OK") {
                    AmplitudeService.sendEvent(
                        key: .ATT_PLUS_SETTING_ALERT_1_OK
                    )
                    self.showParenLogin = true
                }
                
                Spacer(minLength: 16.w)
            }
            .frame(alignment: .center)
            NavigationLink(
                "",
                destination: AttendeeSettingLoginView(
                    shouldPopToRootView: $shouldPopToRootView
                ),
                isActive: $showParenLogin
            )
        }
        .padding(.horizontal, 24.w)
        .padding(.vertical, 24.w)
        .customNavigationViewWithBackCancelWidgit(
            title: "More".localized,
            color: .whiteColor,
            lastButtontitle: "Cancel_Head",
            amplitudeEvent: .ATT_PLUS_LOG_OUT_MAIL_1_BACK,
            action: {
                AmplitudeService.sendEvent(
                    key: .ATT_PLUS_SETTING_ALERT_1_CANCEL
                )
                self.shouldPopToRootView = false
            }
        )
        
        .edgesIgnoringSafeArea(.bottom)
        .background(
            LinearGradient(
                colors: [
                    Color.lightPink,
                    Color.secondaryRed
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
    }
}

/*
struct AttendeeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeSettingsView(shouldPopToRootView: .constant(false))
    }
}*/
