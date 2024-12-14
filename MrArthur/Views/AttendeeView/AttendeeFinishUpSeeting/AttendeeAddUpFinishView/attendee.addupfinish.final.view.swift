//
//  attendee.addupfinish.final.view.swift
//  MrArthur
//
//  Created by IPS-157 on 29/08/22.
//

import SwiftUI

struct AttendeeAddupFinishFinalView: View {
    @EnvironmentObject private var rootViewObserver : RootViewObserver
    @State var showAlert = false
    var body: some View {
        ZStack(alignment: .center){
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 24.h){
                    Text("Perfect!".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    if UtilityMethod.isFrench {
                        
                        Text("On se revoit sur l’appareil de votre enfant pour terminer la configuration. ".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        
                        Text("Revenez à cet écran quand tout est terminé !".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        
                            .multilineTextAlignment(.leading)
                        
                    } else{
                        Group{
                            Text("See you on your child’s device to finish the set up. ")
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("You'll need to sign in with")
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            
                            Text(" YOUR ")
                                .fontModifier(
                                    font: .montserratExtraBold,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("account email.\n\n")
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("You can come back here when all is done.")
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                        }
                    }
                }
                
                Spacer(minLength: 16.h)
                BlueRoundedButton("ALL IS DONE".localized, width: 184) {
                    AmplitudeService.sendEvent(
                        key: .OBS_ADD_UP_FINISH_3_ALL_IS_DONE
                    )
                    rootViewObserver.currentPage = .observerTabBar
                }
            }
            .padding(.horizontal, 24.w)
            .padding(.vertical, 32.w)
            .frame(width: UIScreen.screenWidth)
            if showAlert{
                AlertPopUpView(
                    alertHeading: "you have to install the application\n to your child device first".localized,
                    buttonTitle: "OK".localized,
                    action: {actionStatus in
                        if actionStatus{
                            print("ON Error Popup")
                            rootViewObserver.currentPage = .addAttende
                        }
                        self.showAlert = false
                        
                    }
                )
            }
        }
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
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "DEVICE_OWNER".localized,
            color: .white,
            amplitudeEvent: .OBS_ADD_UP_FINISH_3_BACK
        )
        .edgesIgnoringSafeArea(.all)
    }
}

/*
struct AttendeeAddupFinishFinalView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeAddupFinishFinalView()
            .multiPreview
    }
}*/
