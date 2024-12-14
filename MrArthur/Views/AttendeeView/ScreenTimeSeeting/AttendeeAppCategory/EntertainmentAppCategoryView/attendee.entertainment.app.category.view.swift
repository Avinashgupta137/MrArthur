//
//  attendee.appcategory.view.swift
//  MrArthur
//
//  Created by IPS-157 on 30/08/22.
//

import SwiftUI
import FamilyControls
import DeviceActivity
import ManagedSettings
import Swift

struct AttendeeEntertainmentAppCategoryView: View {
    //MARK: - @AppStorage
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ENTERTAINMENT_FAMILY_ACTIVITY_SELECTION,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var entertainmentFamilyActivitySelection = FamilyActivitySelection()
    
    //MARK: - State Var
    @State private var isEntertainmentTimeSelectionPresented = false
    @State private var isEducationalTimeSelectionPresented = false
    @State var isEntertainmentApp : Bool = false
    @State private var isEntertainmentAppSelected = false
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
                
                HStack (spacing: 0) {
                    VStack(alignment: .leading, spacing: 16.h){
                        AppDeatilsView(
                            image: "IOS_ICONS_SOCIAL",
                            titleImage: " Social "
                        )
                        
                        AppDeatilsView(
                            image: "IOS_ICONS_GAME",
                            titleImage: " Games "
                        )
                        
                        AppDeatilsView(
                            image: "IOS_ICONS_ENTERTAINMENT",
                            titleImage: " Entertainment "
                        )
                        
                    }
                    Spacer(minLength: 16.w)
                }
                
                Spacer(minLength: 16.h)
                
                Image(
                    isEntertainmentAppSelected
                    ? "SettingsAppPick1b"
                    : "SettingsAppPick1"
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
                        key: .OBS_ON_ATTENDEE_SET_UP_1_11_PICK_CATEGORIES
                    )
                    isEntertainmentTimeSelectionPresented = true
                }
                .opacity(isEntertainmentAppSelected ? 0 : 1)
                .disabled(isEntertainmentAppSelected)
            }
            .padding(.horizontal, 24.w)
            .padding(.vertical, 34.h)
            NavigationLink(
                "",
                destination: AttendeeEducationalAppCategoryView(
                    shouldPopToRootView: $shouldPopToRootView,
                    isRediectfromSetting: $isRediectfromSetting
                ),
                isActive: $isEntertainmentApp
            )
            if isEntertainmentTimeSelectionPresented{
                ATTAppcategoryPickerView(
                    onCancel: {
                        AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_12_PICK_CATEGORIES_CANCEL)
                        isEntertainmentTimeSelectionPresented = false
                    },
                    onDone: {
                        AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_12_PICK_CATEGORIES_DONE)
                        isEntertainmentTimeSelectionPresented = false
                        isEntertainmentAppSelected = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_13)
                                self.isEntertainmentApp = true
                            }
                        }
                    }
                ) {
                    FamilyActivityPicker(selection: $entertainmentFamilyActivitySelection)
                }
                .padding()
                .frame(
                    width: UIScreen.screenWidth,
                    height: isRediectfromSetting ? UIScreen.screenHeight * 0.50 : UIScreen.screenHeight * 0.625
                )
                .background(Color.whiteColor.cornerRadius(24.r,corners: [.topLeft, .topRight]))
            }
        }
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "App categories picking".localized,
            color: .white,
            amplitudeEvent: .OBS_ON_ATTENDEE_SET_UP_1_11_BACK
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
