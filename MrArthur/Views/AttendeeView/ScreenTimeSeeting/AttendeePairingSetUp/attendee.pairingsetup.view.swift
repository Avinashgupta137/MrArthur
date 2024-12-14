//
//  attendee.pairingsetup.view.swift
//  MrArthur
//
//  Created by IPS-157 on 29/08/22.
//

import SwiftUI

struct AttendeePairingSetUpView: View {
    //Observed:
    @StateObject var observed = ObservedParentingSetUp()
    
    @State var relayScreen = false
    @State var isActive = false
    @State var isAppSelction = false
    @State var familySharingSetUp = false
    @State var isFamilyControlSetup = false
    @State var educationAppActive = false
    @State var appInstalledInDevice = false
    @State var isRediectfromSetting = false
    @State var paringDeviceStatus = UserDefaultsHelper.paringDevice
    @State var parentSetting : ParentalControlSettingsResponse?
    @State var headerText : String = "The end is in sight!".localized
    @State var bodyText : String = "To start helping your child, complete the next steps. After that we are done!".localized
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 16.h){
                        Text(headerText)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                        Text(bodyText)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                    }
                    Spacer()
                }
                .padding(.bottom, 34.h)
                
                VStack(spacing: 16.h) {
                    Button {
                        AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_1_SET_UP_FAMILY_SHARING)
                        familySharingSetUp = true
                    } label: {
                        ParingSetUpView(
                            paringIndexNumber: "1",
                            paringTitle: "Set up family sharing & invite your child".localized,
                            viewBackgroundColor: .whiteColor,
                            textBackgroundColor: paringDeviceStatus.settingFamilyandInviteChildDone
                            ? .validateGreen
                            : .primaryRed,
                            imageButton: paringDeviceStatus.settingFamilyandInviteChildDone
                            ? "checkmark"
                            : "chevron.forward",
                            imageButtonTintColor: paringDeviceStatus.settingFamilyandInviteChildDone
                            ? .validateGreen
                            : .primaryBlue,
                            isFullOpacity : true
                        )
                    }
                    
                    Button {
                        AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_2_PAIRING_DEVICE)
                        isFamilyControlSetup = true
                    } label: {
                        ParingSetUpView(
                            paringIndexNumber: "2",
                            paringTitle: "Pairing devices".localized,
                            viewBackgroundColor: paringDeviceStatus.paringDevicesDone
                            ? .whiteColor
                            : .paringSetupBackground,
                            textBackgroundColor: paringDeviceStatus.paringDevicesDone
                            ? .validateGreen
                            : .primaryRed,
                            imageButton: paringDeviceStatus.paringDevicesDone
                            ? "checkmark"
                            : "chevron.forward",
                            imageButtonTintColor: paringDeviceStatus.paringDevicesDone
                            ? .validateGreen
                            : paringDeviceStatus.settingFamilyandInviteChildDone ? .primaryBlue : .primaryRed,
                            isFullOpacity : paringDeviceStatus.settingFamilyandInviteChildDone
                        )
                    }
                    .disabled(!paringDeviceStatus.settingFamilyandInviteChildDone)
                    
                    Button {
                        isAppSelction = true
                        AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_4_APP_CATEGORIES_PICKING)
                    } label: {
                        ParingSetUpView(
                            paringIndexNumber: "3",
                            paringTitle: "App categories picking".localized,
                            viewBackgroundColor: paringDeviceStatus.appCategoryPickingDone
                            ? .whiteColor
                            : .paringSetupBackground,
                            textBackgroundColor: paringDeviceStatus.appCategoryPickingDone
                            ? .validateGreen
                            : .primaryRed,
                            imageButton: paringDeviceStatus.appCategoryPickingDone
                            ? "checkmark"
                            : "chevron.forward",
                            imageButtonTintColor: paringDeviceStatus.appCategoryPickingDone
                            ? .validateGreen
                            : paringDeviceStatus.paringDevicesDone ? .primaryBlue : .primaryRed,
                            isFullOpacity : paringDeviceStatus.paringDevicesDone
                        )
                    }
                    .disabled(!paringDeviceStatus.paringDevicesDone)
                    
                    Button {
                        isActive = true
                        AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_5_CONTENT_FILTER)
                    } label: {
                        ParingSetUpView(
                            paringIndexNumber: "4",
                            paringTitle: "Content filtering selection".localized,
                            viewBackgroundColor: paringDeviceStatus.contentFilteringDone
                            ? .whiteColor
                            : .paringSetupBackground,
                            textBackgroundColor: paringDeviceStatus.contentFilteringDone
                            ? .validateGreen
                            : .primaryRed,
                            imageButton: paringDeviceStatus.contentFilteringDone
                            ? "checkmark"
                            : "chevron.forward",
                            imageButtonTintColor: paringDeviceStatus.contentFilteringDone
                            ? .validateGreen
                            : paringDeviceStatus.appCategoryPickingDone ? .primaryBlue : .primaryRed,
                            isFullOpacity : paringDeviceStatus.appCategoryPickingDone
                        )
                    }
                    .disabled(!paringDeviceStatus.appCategoryPickingDone)
                    
                    Button {
                        educationAppActive = true
                        AmplitudeService.sendEvent(
                            key: .OBS_ON_ATTENDEE_SET_UP_1_36_EDUCATIONAL_APP_INSTALLATION
                        )
                    } label: {
                        ParingSetUpView(
                            paringIndexNumber: "5",
                            paringTitle: "Educational app installation".localized,
                            viewBackgroundColor: paringDeviceStatus.educationAppInstallationDone
                            ? .whiteColor
                            : .paringSetupBackground,
                            textBackgroundColor: paringDeviceStatus.educationAppInstallationDone
                            ? .validateGreen
                            : .primaryRed,
                            imageButton: paringDeviceStatus.educationAppInstallationDone
                            ? "checkmark"
                            : "chevron.forward",
                            imageButtonTintColor: paringDeviceStatus.educationAppInstallationDone
                            ? .validateGreen
                            : paringDeviceStatus.contentFilteringDone ? .primaryBlue : .primaryRed,
                            isFullOpacity : paringDeviceStatus.contentFilteringDone
                        )
                    }
                    .disabled(!paringDeviceStatus.contentFilteringDone)
                    
                    Spacer(minLength: 16.h)
                }
                
                if paringDeviceStatus.educationAppInstallationDone || isDevelop {
                    BlueRoundedButton("NEXT") {
                        relayScreen = true
                        AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_6_NEXT)
                        UtilityMethod().setData(
                            value: true,
                            key: ConstantOfApp.kAppSettingDone
                        )
                    }
                }   
                
            }
            
            Group {

                NavigationLink(
                    "",
                    destination: AttendeeFamilySharingSetUp(),
                    isActive: $familySharingSetUp
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
                .labelsHidden()
                
                NavigationLink(
                    "",
                    destination: AttendeeEntertainmentAppCategoryView(
                        shouldPopToRootView: $isAppSelction,
                        isRediectfromSetting: $isRediectfromSetting
                    ),
                    isActive: $isAppSelction
                )
                .labelsHidden()
                
                NavigationLink(
                    "",
                    destination: AttendeeScreenTimeSetupView(
                        shouldPopToRootView: $isFamilyControlSetup
                    ),
                    isActive: $isFamilyControlSetup
                )
                .labelsHidden()
                
                NavigationLink(
                    "",
                    destination: AttendeeStartScreen(),
                    isActive: $relayScreen
                )
                .labelsHidden()
                
                NavigationLink(
                    "",
                    destination: AttendeeEducationalAppInstallationView(
                        appInstalledInDevice: $appInstalledInDevice
                    ),
                    isActive: $educationAppActive
                )
                .labelsHidden()
            }
        }
        .padding(.vertical, 32.h)
        .padding(.horizontal, 24.w)
        .onAppear {
            isRediectfromSetting = false
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
        .onChange(of: paringDeviceStatus.educationAppInstallationDone, perform: { setupDone in
            if setupDone == true{
                self.headerText = "Everything is ready!".localized
                self.bodyText = "Let’s help your child together!".localized
            }
            else{
                self.headerText = "The end is in sight!".localized
                self.bodyText = "To start helping your child, complete the next steps. After that we are done!".localized
            }
        })
        .customNavigationView(
            title: "Pairing setup".localized,
            color: .white
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

//struct AttendeePairingSetUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeePairingSetUpView()
//            .multiPreview
//    }
//}
