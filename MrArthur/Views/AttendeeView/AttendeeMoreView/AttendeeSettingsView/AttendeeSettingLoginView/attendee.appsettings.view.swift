//
//  attendee.appsettings.view.swift
//  MrArthur
//
//  Created by Amit Sinha on 03/11/22.
//

import SwiftUI

struct AttendeeAppsettingsView: View {
    @State var showAppSeetings = false
    @State var showPopup = false
    @State var isActive = false
    @State var isAppSelction = false
    @State var educationAppActive = false
    @State var appInstalledInDevice = false
    @State var isRediectfromSetting = true
    @StateObject var observed = ObservedParentingSetUp()
    @State var paringDeviceStatus = UserDefaultsHelper.paringDevice
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @Binding var shouldPopToRootView : Bool
    @State var parentSetting : ParentalControlSettingsResponse?
    var body: some View {
        VStack(alignment: .leading){
            Button {
                withAnimation{
                    isAppSelction = true
                    AmplitudeService.sendEvent(
                        key: .ATT_PLUS_LOG_OUT_1_APP_CATEGORIES_PICKING
                    )
                }
            } label: {
                MoreCardSectionView(
                    buttonImage: "chevron.forward",
                    isSystemImage: true,
                    buttonTitle: "APP CATEGORIES PICKING".localized
                )
            }
            Button {
                withAnimation{
                    isActive = true
                    AmplitudeService.sendEvent(
                        key: .ATT_PLUS_LOG_OUT_1_CONTENT_FILTERING_SELECTION
                    )
                }
            } label: {
                MoreCardSectionView(
                    buttonImage: "chevron.forward",
                    isSystemImage: true,
                    buttonTitle: "CONTENT FILTERING SELECTION".localized
                )
            }
            Button {
                withAnimation{
                    AmplitudeService.sendEvent(
                        key: .ATT_PLUS_LOG_OUT_1_EDUCATIONAL_APP_INSTALLATION
                    )
                    educationAppActive = true
                }
            } label: {
                MoreCardSectionView(
                    buttonImage: "chevron.forward",
                    isSystemImage: true,
                    buttonTitle: "EDUCATIONAL APP INSTALLATION".localized
                )
            }
            Spacer()
            NavigationLink(
                "",
                destination: AttendeeEntertainmentAppCategoryView(
                    shouldPopToRootView: $isAppSelction,
                    isRediectfromSetting: $isRediectfromSetting
                ),
                isActive: $isAppSelction
            )
            
            NavigationLink(
                "",
                destination: AttendeeContentFilteringSelectionView(
                    shouldPopToRootView: $isActive,
                    contentFilteringSelection: .constant(paringDeviceStatus.educationAppInstallationDone),
                    parentSetting: $parentSetting
                ) ,
                isActive: $isActive
            )
            
            NavigationLink(
                "",
                destination: AttendeeEducationalAppInstallationView(
                    appInstalledInDevice: $appInstalledInDevice
                ),
                isActive: $educationAppActive
            )
        }
        .onAppear{
            isRediectfromSetting = true
        }
        .padding(.vertical, 34.h)
        .padding(.horizontal, 24.w)
        .onAppear {
            paringDeviceStatus = UserDefaultsHelper.paringDevice
            ParentControlSetting.getParentControlSettingAPICall() { status, response in
                if let settings = response {
                    if (settings.preset != .NOT_SET_YET) {
                        parentSetting = response
                        ManagedSettingsService.setParentalControlSettings(preset: settings.preset)
                    }
                    if (settings.restPeriod != .NOT_SET_YET) {
                        parentSetting = response
                        RestPeriodService.setLocalRestPeriod(restPeriod: settings.restPeriod)
                    }
                }
            }
        }
        .customNavigationViewWithBackCancelWidgit(
            title: "SETTINGS".localized,
            color: .whiteColor,
            lastButtontitle: "Cancel_Head",
            amplitudeEvent: .ATT_PLUS_LOG_OUT_1_BACK,
            action: {
                self.shouldPopToRootView = false
                AmplitudeService.sendEvent(
                    key: .ATT_PLUS_LOG_OUT_1_CANCEL
                )
            }
        )
        .background(
            LinearGradient(
                colors: [Color.lightPink, Color.secondaryRed],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}
