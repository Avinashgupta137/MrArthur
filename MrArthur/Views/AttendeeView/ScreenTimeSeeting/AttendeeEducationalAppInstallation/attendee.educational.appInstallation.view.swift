//
//  attendee.educational.appInstallation.view.swift
//  MrArthur
//
//  Created by IPS-157 on 30/08/22.
//

import SwiftUI

struct AttendeeEducationalAppInstallationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var observed = ObservedEducation()
    @Binding var appInstalledInDevice : Bool
    var body: some View {
        ZStack(alignment: .bottom){
            ScrollView(showsIndicators: false){
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 16.h) {
                        Text("Last step!".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                        Group{
                            Text(UtilityMethod.isFrench ? "mr.arthur " : "")
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("Please install those educational apps we have chosen for you. The selection was done according to 3 criteria:".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                        }
                        Text("• Educational content quality".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        
                        Text("• Enough free content".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        
                        Text("• Fun and engaging".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                    }
                    
                    VStack(spacing: 24.h){
                        ForEach(
                            0..<observed.arrOfRecommandedAppData.count,
                            id: \.self) { i in
                                EducationalAppCardView(
                                    app: observed.arrOfRecommandedAppData[i],
                                    appInstalledInDevice: observed.isAppInstalled(
                                        appUUID: observed.arrOfRecommandedAppData[i].appUuid
                                    ),
                                    onInstall: {
                                        AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_38_INSTALL_APP)
                                        observed.installApp(
                                            appUrl: observed.arrOfRecommandedAppData[i].appLink,
                                            appUDID: observed.arrOfRecommandedAppData[i].appUuid
                                        )
                                    },
                                    onShare: {
                                        AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_38_SHARE)
                                        observed.shareApp(
                                            appUrl: observed.arrOfRecommandedAppData[i].appLink,
                                            appUDID: observed.arrOfRecommandedAppData[i].appUuid
                                        )
                                    },
                                    onSeeOnAppStore: {
                                        AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_38_SEE_ON_APPSTORE)
                                        observed.seeOnAppStore(
                                            appUrl: observed.arrOfRecommandedAppData[i].appLink
                                        )
                                    }
                                )
                            }
                    }
                    .padding(.top, 24.h)
                    .padding(.horizontal, 3.h)
                }
            }
            .padding(.top, 32.h)
            .padding(.horizontal, 24.w)
            .onAppear {
                let appIdentifier = DeviceService.getAppIdentifier()
                print("App Identifier: - \(appIdentifier)")
                observed.getRecommendedAppList()
            }
            .zIndex(0)
            BlueRoundedButton("Done") {
                AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_37_DONE)
                var  deviceSetupStatus = UserDefaultsHelper.paringDevice
                deviceSetupStatus.educationAppInstallationDone = true
                UserDefaultsHelper.paringDevice =  deviceSetupStatus
                self.presentationMode.wrappedValue.dismiss()
            }
            .contentShape(Rectangle())
            .zIndex(1)
            .padding(.bottom, 30.iPadIncBy_50)
        }
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "Educational app installation".localized,
            color: .white,
            amplitudeEvent: .OBS_ON_ATTENDEE_SET_UP_1_37_BACK
        )
        .background(
            LinearGradient(
                colors: [
                    Color.secondaryRed,
                    Color.lightPink
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
    }
    
}

struct AttendeeEducationalAppInstallationView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeEducationalAppInstallationView(
            appInstalledInDevice: .constant(false)
        )
        .multiPreview
    }
}


