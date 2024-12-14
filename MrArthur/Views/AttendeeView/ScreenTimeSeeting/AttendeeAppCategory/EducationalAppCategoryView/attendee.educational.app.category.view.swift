//
//  attendee.app.educational.view.swift
//  MrArthur
//
//  Created by Amit Sinha on 04/11/22.
//

import SwiftUI
import FamilyControls
import DeviceActivity
import ManagedSettings
import Swift

struct AttendeeEducationalAppCategoryView: View {
    //MARK: - @AppStorage
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.EDUCATIONAL_FAMILY_ACTIVITY_SELECTION,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var educationalFamilyActivitySelection = FamilyActivitySelection()
    
    //MARK: - State Var
    @State private var isEducationalTimeSelectionPresented = false
    @State private var isEducationalAppSelected = false
    @State private var isAllCategory = false
    @Binding var shouldPopToRootView : Bool
    @Binding var isRediectfromSetting : Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0){
                HStack(spacing: 0) {
                    Text("Carefully pick ".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: 18.sp,
                            color: .primaryBlue
                        )
                    +
                    Text("only".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: 18.sp,
                            color: .primaryBlue
                        )
                    +
                    Text(" the following categories.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: 18.sp,
                            color: .primaryBlue
                        )
                    Spacer(minLength: 16.w)
                }
                .padding(.bottom, 16.h)
                HStack(spacing: 0) {
                    AppDeatilsView(
                        image: "IOS_ICONS_EDUCATION",
                        titleImage: " Education "
                    )
                    Spacer(minLength: 16.h)
                }
                Spacer()
                Image(
                    isEducationalAppSelected
                    ? "SettingsAppPick2b"
                    : "SettingsAppPick2"
                )
                .resizable()
                .scaledToFit()
                .frame(
                    width: 255.r,
                    height: 255.r
                )
                
                Spacer(minLength: 16.h)
                
                BlueRoundedButton(
                    "PICK CATEGORIES",
                    width: 255.27
                ) {
                    AmplitudeService.sendEvent(
                        key: .OBS_ON_ATTENDEE_SET_UP_1_14_PICK_CATEGORIES
                    )
                    isEducationalTimeSelectionPresented = true
                }
                .opacity(isEducationalAppSelected ? 0 : 1)
                .disabled(isEducationalAppSelected)
                
            }
            .padding(.horizontal, 24.w)
            .padding(.vertical, 34.h)
            NavigationLink(
                "",
                destination: AttendeeAllCategoryAppView(
                    shouldPopToRootView: $shouldPopToRootView,
                    isRediectfromSetting: $isRediectfromSetting
                ),
                isActive: $isAllCategory
            )
            if isEducationalTimeSelectionPresented{
                ATTAppcategoryPickerView(
                    onCancel: {
                        AmplitudeService.sendEvent(
                            key: .OBS_ON_ATTENDEE_SET_UP_1_15_PICK_CATEGORIES_CANCEL
                        )
                        isEducationalTimeSelectionPresented = false
                    },
                    onDone: {
                        AmplitudeService.sendEvent(
                            key: .OBS_ON_ATTENDEE_SET_UP_1_15_PICK_CATEGORIES_DONE
                        )
                        isEducationalTimeSelectionPresented = false
                        isEducationalAppSelected = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                AmplitudeService.sendEvent(
                                    key: .OBS_ON_ATTENDEE_SET_UP_1_16
                                )
                                self.isAllCategory = true
                            }
                        }
                    }
                ) {
                    FamilyActivityPicker(selection: $educationalFamilyActivitySelection)
                }
                .padding()
                .frame(width: UIScreen.screenWidth, height: isRediectfromSetting ? UIScreen.screenHeight * 0.50 : UIScreen.screenHeight * 0.625)
                .background(Color.whiteColor.cornerRadius(24.r,corners: [.topLeft, .topRight]))
            }
        }
        
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "App categories picking".localized,
            color: .white,
            amplitudeEvent: .OBS_ON_ATTENDEE_SET_UP_1_14_BACK
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
