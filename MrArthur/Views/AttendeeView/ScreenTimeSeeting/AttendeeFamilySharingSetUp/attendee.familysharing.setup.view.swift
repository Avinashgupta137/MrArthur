//
//  attendee.familysharing.setup.view.swift
//  MrArthur
//
//  Created by IPS-157 on 30/08/22.
//

import SwiftUI

struct AttendeeFamilySharingSetUp: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack(spacing: 0) {
                Text("ATTENDEE_SETTINGS_SHARE_INVITE".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont25,
                        color: .primaryBlue
                    )
                Spacer()
            }
            .padding(.bottom, 42.h)
            
            VStack(alignment: .leading, spacing: 16.h){
                FamilySharingSetupCellView(icon: "AppleSettingsIcon") {
                    Text("Go to Settings on this device".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                        .minimumScaleFactor(0.5)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                FamilySharingSetupCellView {
                    VStack(alignment: .leading, spacing: 0){
                        Text("Tap your Apple account name".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                            .minimumScaleFactor(0.5)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("Create your Apple ID account if you haven’t yet".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                            .minimumScaleFactor(0.5)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(height: 59.h)
                }
                
                FamilySharingSetupCellView(icon: "AppleFamilyShareIcon") {
                    Text("Tap Family Sharing".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                        .minimumScaleFactor(0.5)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                FamilySharingSetupCellView(icon: "SettingsAddMember") {
                    Text("Tap Add Member".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                }
                
                FamilySharingSetupCellView(icon: "SettingsFollowInstructions") {
                    VStack(alignment: .leading, spacing: 0){
                        Text("Follow the instructions".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                        Text("Complete your family setup".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                    }
                    .frame(height: 59.h)
                }
                
                FamilySharingSetupCellView(icon: "SettingsMrArturLogo") {
                    Group{
                        Text("ATTENDEE_SETTINGS_RETURN_TO".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont15,
                                color: .primaryBlue)
                        +
                        Text("mr.arthur".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                    }
                }
            }
            .padding(24.r)
            .background(Color.whiteColor.cornerRadius(28.r))
            
            Spacer(minLength: 16.h)
            
            BlueRoundedButton("DONE".localized) {
                AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_27_DONE)
                var  deviceSetupStatus = UserDefaultsHelper.paringDevice
                deviceSetupStatus.settingFamilyandInviteChildDone = true
                UserDefaultsHelper.paringDevice =  deviceSetupStatus
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .padding(24.r)
        .background(
            LinearGradient(colors: [Color.secondaryRed, Color.lightPink],
                           startPoint: .top,
                           endPoint: .bottomTrailing)
        )
        .customNavigationViewWithBackWidgit(
            title: "Pairing setup".localized,
            color: .white
        )
    }
    
}

struct AttendeeFamilySharingSetUp_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeFamilySharingSetUp()
//            .multiPreview
    }
}
