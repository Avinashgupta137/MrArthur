//
//  attendee.screentime.setup.view.swift
//  MrArthur
//
//  Created by IPS-157 on 30/08/22.
//

import SwiftUI
import FamilyControls
import DeviceActivity
import ManagedSettings
import Swift
import Intercom

struct AttendeeScreenTimeSetupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var showErrorPopup = false
    @State var dismissButton = false
    @State var alertMessage = ""
    @State var actionButtonTitle = ""
    @State var actionButtonShow = false
    @Binding var shouldPopToRootView : Bool
    
    var body: some View {
        ZStack(alignment: .center){
            VStack(spacing: 0){
                Text("Sign in with your parent or guardian Apple account. This is requiered to pair the devices and enable parental control.".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont18,
                        color: .primaryBlue
                    )
                
                Spacer(minLength: 16.h)
                BlueRoundedButton(
                    "SIGN IN WITH PARENT’S APPLE ID",
                    width: 380
                ) {
                    AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_3_NEXT)
                    self.showErrorPopup = false
                    FamilyControlService.AuthorizationSet{ status, message, errorCode in
                        if let errorCode = errorCode{
                            self.showErrorPopup = true
                            switch(errorCode){
                            case 0:
                                AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_CASE_0)
                                alertMessage = "A restriction prevents your app from using Family Controls on this device. \n\nMost probable cause: You are not on your child’s device, or his Apple ID account is not a child account (his age has to be set under 18)".localized
                                actionButtonTitle = "GO TO APPLE ID SETTINGS"
                                actionButtonShow = true
                                
                            case 1:
                                AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_CASE_1)
                                alertMessage = "Sorry we might have a problem on our side.".localized
                                actionButtonTitle = ""
                                actionButtonShow = false
                            case 2:
                                AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_CASE_2)
                                alertMessage = "The device isn't signed into a valid Apple ID account. \n\nPlease check you're using the right Apple ID account in your device's settings.".localized
                                actionButtonTitle = "GO TO APPLE ID SETTINGS"
                                actionButtonShow = true
                            case 3:
                                AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_CASE_3)
                                alertMessage = "Sorry we might have a problem on our side.".localized
                                actionButtonTitle = ""
                                actionButtonShow = false
                            case 4:
                                AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_CASE_4)
                                alertMessage = "You seem to be already using a parental control app or Apple Screen Time. You can't use several parental control apps at the same time. \n\nPlease turn off other apps or Apple Screen Time in your devices settings.".localized
                                actionButtonTitle = "GO TO SETTINGS"
                                actionButtonShow = true
                            case 5:
                                AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_CASE_4)
                                alertMessage = "Please retry to pair devices.".localized
                                actionButtonTitle = "OK"
                                actionButtonShow = true
                            case 6:
                                AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_CASE_6)
                                alertMessage = "Sorry but you seem to be offline. \n\nPlease check your network connexion and retry".localized
                                actionButtonTitle = "OK"
                                actionButtonShow = true
                            default:
                                AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_DEFAULT)
                                alertMessage = "Sorry we might have a problem on our side".localized
                                actionButtonTitle = ""
                                actionButtonShow = false
                                break
                            }
                        }else{
                            var deviceSetupStatus = UserDefaultsHelper.paringDevice
                            deviceSetupStatus.paringDevicesDone = true
                            UserDefaultsHelper.paringDevice =  deviceSetupStatus
                            AmplitudeService.sendEvent(key: .OBS_ON_ATTENDEE_SET_UP_1_8)
                            shouldPopToRootView = false
                        }
                    }
                }
                .opacity(showErrorPopup ? 0.4 : 1 )
                .disabled(showErrorPopup)
            }
            if self.showErrorPopup{
                FamilyAuthFailurePopUpView(
                    alertMessage: alertMessage.localized,
                    actionButtonTitle: actionButtonTitle.localized,
                    action: {
                        if actionButtonTitle == "OK"{
                            print("OK")
                            self.showErrorPopup = false
                        }
                        else if actionButtonTitle == "GO TO APPLE ID SETTINGS"{
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            self.showErrorPopup = false
                        }
                        else if actionButtonTitle == "GO TO SETTINGS"{
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            self.showErrorPopup = false
                        }
                    },
                    actionButtonShow: actionButtonShow,
                    contactSupport: {
                        self.onAppearMessage()
                        self.showErrorPopup = false
                    }
                )
            }
        }
        .padding(.vertical, 36.h)
        .padding(.horizontal, 24.w)
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "Pairing devices".localized,
            color: .white,
            amplitudeEvent: .OBS_ON_ATTENDEE_SET_UP_1_8_BACK
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
    func onAppearMessage(){
        let attendeeEmail = UserDefaultsHelper.selectedAttendee?.intercomEmail
        IntercomMessageService().registerMail(email: attendeeEmail)
    }
}
