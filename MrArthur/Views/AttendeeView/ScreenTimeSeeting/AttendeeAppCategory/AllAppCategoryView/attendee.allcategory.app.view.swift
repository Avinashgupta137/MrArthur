//
//  attendee.allcategory.view.swift
//  MrArthur
//
//  Created by Amit Sinha on 04/11/22.
//

import SwiftUI
import FamilyControls
import DeviceActivity
import ManagedSettings
import Swift

struct AttendeeAllCategoryAppView: View {
    //MARK: - @AppStorage
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ALL_CATEGORY_FAMILY_ACTIVITY_SELECTION,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var allCategoryFamilyActivitySelection = FamilyActivitySelection()
    
    
    //MARK: - State Var
    @State private var isAllCategorySelectionPresented = false
    @State private var isAllCategorySelected = false
    @State private var isBrowsingAppBlock = false
    @Binding var shouldPopToRootView : Bool
    @Binding var isRediectfromSetting : Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(){
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
                    Spacer()
                }
                HStack(spacing: 0) {
                    AppDeatilsView(
                        image: "IOS_ICONS_ALL-APPS",
                        titleImage: " All apps & Categories "
                    )
                    Spacer(minLength: 5.h)
                }
                
                Spacer()
                Image(isAllCategorySelected ? "SettingsAppPick3b" : "SettingsAppPick3")
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
                        key: .OBS_ON_ATTENDEE_SET_UP_1_19_PICK_CATEGORIES
                    )
                    isAllCategorySelectionPresented = true
                }
                .opacity(isAllCategorySelected ? 0 : 1)
                .disabled(isAllCategorySelected)
            }
            .padding(.horizontal, 24.w)
            .padding(.vertical, 34.h)
            NavigationLink(
                "",
                destination: AttendeeForbiddenbrowsersAppView(
                    shouldPopToRootView: $shouldPopToRootView,
                    isRediectfromSetting: $isRediectfromSetting
                ),
                isActive: $isBrowsingAppBlock
            )
            if isAllCategorySelectionPresented{
                ATTAppcategoryPickerView(
                    onCancel: {
                        AmplitudeService.sendEvent(
                            key: .OBS_ON_ATTENDEE_SET_UP_1_17_PICK_CATEGORIES_CANCEL
                        )
                        isAllCategorySelectionPresented = false
                    },
                    onDone: {
                        AmplitudeService.sendEvent(
                            key: .OBS_ON_ATTENDEE_SET_UP_1_17_PICK_CATEGORIES_DONE
                        )
                        isAllCategorySelectionPresented = false
                        isAllCategorySelected = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                AmplitudeService.sendEvent(
                                    key: .OBS_ON_ATTENDEE_SET_UP_1_18
                                )
                                self.isBrowsingAppBlock = true
                            }
                        }
                    }
                ) {
                    FamilyActivityPicker(selection: $allCategoryFamilyActivitySelection)
                }
                .padding()
                .frame(width: UIScreen.screenWidth, height: isRediectfromSetting ? UIScreen.screenHeight * 0.50 : UIScreen.screenHeight * 0.625)
                .background(Color.whiteColor.cornerRadius(24.r,corners: [.topLeft, .topRight]))
            }
        }
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "App categories picking".localized,
            color: .white,
            amplitudeEvent: .OBS_ON_ATTENDEE_SET_UP_1_19_BACK
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
