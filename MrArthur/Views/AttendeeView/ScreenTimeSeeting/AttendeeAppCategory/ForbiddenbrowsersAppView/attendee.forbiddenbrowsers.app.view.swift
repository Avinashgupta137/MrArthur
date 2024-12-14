//
//  screentime.app.picker.view.swift
//  MrArthur
//
//  Created by Amit Sinha on 30/9/22.
//

import SwiftUI
import FamilyControls
import DeviceActivity
import ManagedSettings
import Swift

struct AttendeeForbiddenbrowsersAppView: View {
    //MARK: - @AppStorage
    @AppStorage(
        ExtensionSharedAppGroupService.keys.FORBIDDEN_BROWSERS_FAMILY_ACTIVITY_SELECTION,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var forbiddenBrowsersFamilyActivitySelection = FamilyActivitySelection()
    
    //MARK: - State Var
    @State private var isForbiddenBrowsersAppSelected = false
    @State private var isBrowserAppSelected = false
    @State var showErrorPopup = false
    @Binding var shouldPopToRootView : Bool
    @Binding var isRediectfromSetting : Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack(alignment: showErrorPopup ? .center : .bottom){
            VStack(spacing: 0){
                VStack(spacing: 0) {
                    HStack{
                        Image("IOS_ICONS_SAFARI")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40.r, height: 40.r)
                            .background(Color.white.cornerRadius(28.r))
                        Group{
                            Text("mr.arthur ".localized)
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("to work, your child has to use only ".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("Safari.".localized)
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                        }
                        Spacer()
                    }
                    .padding(.bottom, 10.r)
                    
                    HStack{
                        Image("IOS_ICONS_UTILITIES")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80.r, height: 40.r)
                        VStack{
                            Text("Tap the right arrow of the « Utilities » category and pick those apps if they show up. We will block them.".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                        }
                        .padding(.horizontal, 10.w)
                        Spacer()
                    }
                }
                .padding(.bottom, 15.r)
                
                HStack{
                    BrowserDetails(
                        image: "IOS_ICONS_CHROME",
                        titleImage: "Chrome"
                    )
                    BrowserDetails(
                        image: "IOS_ICONS_OPERA",
                        titleImage: "Opera"
                    )
                    BrowserDetails(
                        image: "IOS_ICONS_FIREFOX",
                        titleImage: "Firefox"
                    )
                    Spacer()
                }
                Spacer(minLength: 16.h)
                
                Image(isBrowserAppSelected ? "SettingsAppPick5b" : "SettingsAppPick5")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 255.r,
                        height: 255.r
                    )
                Spacer()
                
                BlueRoundedButton(
                    "PICK APPS",
                    width: 255.27
                ) {
                    AmplitudeService.sendEvent(
                        key: .OBS_ON_ATTENDEE_SET_UP_1_44_PICK_APP
                    )
                    isForbiddenBrowsersAppSelected = true
                }
                .opacity(isBrowserAppSelected ? 0 : 1)
                .disabled(isBrowserAppSelected)
            }
            .padding(.horizontal, 24.w)
            .padding(.vertical, 34.h)
            if isForbiddenBrowsersAppSelected{
                ATTAppcategoryPickerView(
                    onCancel: {
                        AmplitudeService.sendEvent(
                            key: .OBS_ON_ATTENDEE_SET_UP_1_42_PICK_APP_CANCEL
                        )
                        isForbiddenBrowsersAppSelected = false
                    },
                    onDone: {
                        AmplitudeService.sendEvent(
                            key: .OBS_ON_ATTENDEE_SET_UP_1_42_PICK_APP_DONE
                        )
                        isForbiddenBrowsersAppSelected = false
                        let categoryselectionCount : Int = forbiddenBrowsersFamilyActivitySelection.categories.count
                        if categoryselectionCount > 0 {
                            AmplitudeService.sendEvent(
                                key: .OBS_ON_ATTENDEE_SET_UP_1_45
                            )
                            showErrorPopup = true
                            isBrowserAppSelected = false
                            print("forbiddenBrowsersFamilyActivitySelection: \(forbiddenBrowsersFamilyActivitySelection.categories.count)")
                        }
                        else{
                            AmplitudeService.sendEvent(
                                key: .OBS_ON_ATTENDEE_SET_UP_1_43
                            )
                            isBrowserAppSelected = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation {
                                    var deviceSetupStatus = UserDefaultsHelper.paringDevice
                                    deviceSetupStatus.appCategoryPickingDone = true
                                    UserDefaultsHelper.paringDevice =  deviceSetupStatus
                                    self.shouldPopToRootView = false
                                    self.isRediectfromSetting = false
                                }
                            }
                        }
                    }
                ) {
                    FamilyActivityPicker(selection: $forbiddenBrowsersFamilyActivitySelection)
                }
                .padding()
                .frame(
                    width: UIScreen.screenWidth,
                    height: isRediectfromSetting ? UIScreen.screenHeight * 0.50 : UIScreen.screenHeight * 0.625
                )
                .background(Color.whiteColor.cornerRadius(24.r, corners: [.topLeft, .topRight]))
            }
            
            if self.showErrorPopup{
                AlertPopUpView(
                    alertHeading: "You made a mistake!\n\n You need to pick the\n apps to block NOT a\n category ;)".localized,
                    buttonTitle: "OK, I GET IT!".localized,
                    action: {actionStatus in
                        if actionStatus{
                            print("ON Error Popup")
                        }
                        self.showErrorPopup = false
                    }
                )
            }
        }
        .customNavigationViewWithBackCancelWidgit(
            title: "App Picking".localized,
            color: .white,
            showBackButton: true,
            lastButtontitle: "Skip",
            amplitudeEvent: .OBS_ON_ATTENDEE_SET_UP_1_42_PICK_APP_CANCEL,
            action: {
                AmplitudeService.sendEvent(
                    key: .OBS_ON_ATTENDEE_SET_UP_1_42_SKIP
                )
                var deviceSetupStatus = UserDefaultsHelper.paringDevice
                deviceSetupStatus.appCategoryPickingDone = true
                UserDefaultsHelper.paringDevice =  deviceSetupStatus
                self.shouldPopToRootView = false
                self.isRediectfromSetting = false
            }
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
/*
struct AttendeeForbiddenbrowsersAppView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeForbiddenbrowsersAppView(
            showErrorPopup: false,
            shouldPopToRootView: .constant(false),
            isRediectfromSetting: .constant(false)
        )
        .multiPreview
    }
}
*/
