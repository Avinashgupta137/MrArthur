//
//  attendee.contentfilteringselection.view.swift
//  MrArthur
//
//  Created by IPS-157 on 30/08/22.
//
//contentFilteringAppIcon
//lowShieldIcon
//mediumShieldIcon
//noShieldIcon
//socialShieldGreen
//socialShieldRed
//strongShieldIcon
import SwiftUI

struct AttendeeContentFilteringSelectionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var shouldPopToRootView : Bool
    @Binding var contentFilteringSelection : Bool
    @State var isActiveSelected = false
    @Binding var parentSetting : ParentalControlSettingsResponse?
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0){
                
                Text("Choose your protection !".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont25,
                        color: .primaryBlue
                    )
                    .padding(.bottom, 10.h)
                
                Group{
                    Text("To protect your child, ".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .primaryBlue
                        ) +
                    Text("mr.arthur".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont18,
                            color: .primaryBlue
                        )
                    +
                    Text(" offers 3 different levels of content filtering.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .primaryBlue
                        )
                }
                .padding(.bottom, 50.h)
                
                VStack(spacing: 47.r){
                    StrongContentFilterSelectionView(
                        isSelected: (parentSetting?.preset == EParentalControlSettingsPreset.FROM_08),
                        onTap: {
                            self.onTapAction(settingFor: .FROM_08){
                                AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_20_HIGH_LEVEL_SELECT)
                                ManagedSettingsService.setFROM08()
                            }
                        }
                    )
                    
                    MediumContentFilterSelectionView(
                        isSelected: (parentSetting?.preset == EParentalControlSettingsPreset.FROM_10),
                        onTap: {
                            self.onTapAction(settingFor: .FROM_10) {
                                AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_20_MEDIUM_LEVEL_SELECT)
                                ManagedSettingsService.setFROM10()
                            }
                        }
                    )
                    
                    LowContentFilterSelectionView(
                        isSelected: (parentSetting?.preset == EParentalControlSettingsPreset.FROM_12)
                    ) {
                        self.onTapAction(settingFor: .FROM_12) {
                            AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_20_LOW_LEVEL_SELECT)
                            ManagedSettingsService.setFROM12()
                        }
                    }
                    
                    NoContentFilterselectionView(
                        isSelected: (parentSetting?.preset == EParentalControlSettingsPreset.NO_FILTER)
                    ) {
                        self.onTapAction(settingFor: .NO_FILTER) {
                            AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_20_NO_CONTECT_SELECT)
                            ManagedSettingsService.setNoFilter()
                        }
                    }
                }
                
                Spacer()
                
                NavigationLink(
                    "",
                    destination: AttendeeRestPeriodSelectionView(
                        shouldPopToRootView: $shouldPopToRootView, parentSetting: $parentSetting
                    ),
                    isActive: $isActiveSelected
                )
                .labelsHidden()
            }
        }
        .padding(.vertical, 32.h)
        .padding(.horizontal, 24.h)
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "Content filtering selection".localized,
            color: .white,
            amplitudeEvent: .OBS_ON_ATTENDEE_SET_UP_1_20_BACK
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
    
    private func onTapAction(
        settingFor: EParentalControlSettingsPreset,
        onSuccess: @escaping() -> ()
    ) {
        ParentControlSetting.updateParentControlSettingAPICall(
            preset: settingFor
        ) { status, message, updateParentControlResponse in
            print("Response of update parent control = \(updateParentControlResponse), status = \(status)")
            if(status == true){
                contentFilteringSelection = true
                isActiveSelected = true
                onSuccess()
            }else{
                //Only for Testing Purpose
                contentFilteringSelection = true
                isActiveSelected = true
                print("error is \(message)")
            }
        }
    }
}


/*struct AttendeeContentFilteringSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeContentFilteringSelectionView(
            shouldPopToRootView: .constant(true),
            contentFilteringSelection: .constant(false)
        )
//        .multiPreview
    }
}*/
